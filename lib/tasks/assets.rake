namespace :assets do
  task :precompile => :environment do
    puts ENV['DATABASE_URL']
  end
end
