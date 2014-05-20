require 'spec_helper'

describe Filter do

  let(:safe_user) do
    double(Twitter::User, name: 'Hello Kitty', screen_name: 'hello_kitty')
  end

  it "filters tweets that do not say 'go to collage'" do
    tweet = double(Twitter::Tweet, text: 'going to collage', user: safe_user)
    expect(described_class.new(tweet)).to be_filter
  end

  it 'filters reply tweets that start with an @' do
    tweet = double(Twitter::Tweet, text: "@you I'm go to collage", user: safe_user)
    expect(described_class.new(tweet)).to be_filter
  end

  it 'filters tweets that include profanity' do
    Filter::SWEARS.each do |swear|
      tweet = double(Twitter::Tweet, text: "go to collage #{swear.upcase}", user: safe_user)
      expect(described_class.new(tweet)).to be_filter
    end
  end

  it 'filters tweets that include anything racial' do
    Filter::SLURS.each do |slur|
      tweet = double(Twitter::Tweet, text: "go to collage #{slur.upcase}", user: safe_user)
      expect(described_class.new(tweet)).to be_filter
    end
  end

  it 'filters tweets that start with RT' do
    tweet = double(Twitter::Tweet, text: "RT go to collage", user: safe_user)
    expect(described_class.new(tweet)).to be_filter
  end

  it 'filters tweets that start with quotes' do
    %w(' " “).each do |q|
      tweet = double(Twitter::Tweet, text: "#{q}go to collage'", user: safe_user)
      expect(described_class.new(tweet)).to be_filter
    end
  end

  it 'filters tweets from users with name with profanity' do
    user = double(Twitter::User, name: Filter::SWEARS.first, screen_name: 'hello_kitty')
    tweet = double(Twitter::Tweet, text: 'go to collage', user: user)
    expect(described_class.new(tweet)).to be_filter
  end

  it 'filters tweets from users with screen_names with profanity' do
    user = double(Twitter::User, screen_name: Filter::SWEARS.first, name: 'Hello Kitty')
    tweet = double(Twitter::Tweet, text: 'go to collage', user: user)
    expect(described_class.new(tweet)).to be_filter
  end

end
