# config/unicorn.rb
worker_processes 1
timeout 15
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  @worker_pid = spawn('bundle exec sidekiq -c 3')
  t = Thread.new {
    Process.wait(@worker_pid)
    puts "Worker died. Bouncing unicorn."
    Process.kill 'QUIT', Process.pid
  }
  t.abort_on_exception = true

  ActiveRecord::Base.establish_connection
end
