require 'spec_helper'

describe Filter do

  it "filters tweets that do not say 'go to collage'" do
    tweet = double(Twitter::Tweet, text: 'going to collage')
    expect(described_class.new(tweet)).to be_filter
  end

  it 'filters reply tweets that start with an @' do
    tweet = double(Twitter::Tweet, text: "@you I'm go to collage")
    expect(described_class.new(tweet)).to be_filter
  end

  it 'filters tweets that include profanity' do
    Filter::SWEARS.each do |swear|
      tweet = double(Twitter::Tweet, text: "go to collage #{swear}")
      expect(described_class.new(tweet)).to be_filter
    end
  end

  it 'filters tweets that include anything racial' do
    Filter::SLURS.each do |slur|
      tweet = double(Twitter::Tweet, text: "go to collage #{slur}")
      expect(described_class.new(tweet)).to be_filter
    end
  end

  it 'filters tweets that start with RT' do
    tweet = double(Twitter::Tweet, text: "RT go to collage")
    expect(described_class.new(tweet)).to be_filter
  end

end
