class Filter
  SWEARS = %w(shit fuck ass dick cunt pussy bitch)
  SLURS = %w(fag gay homo nigga nigger nig)

  attr_reader :tweet

  def initialize(tweet)
    @tweet = tweet
  end

  def filter?
    return true unless includes_exact_phrase?
    return true unless non_reply?
    return true unless excludes_swears?
    return true unless excludes_slurs?
    return true unless not_retweeted_old_school_style?
    false
  end

  def includes_exact_phrase?
    tweet.text =~ /go to collage/
  end

  def non_reply?
    tweet.text =~ /\A[^@]/
  end

  def excludes_swears?
    SWEARS.none? do |swear|
      tweet.text =~ /#{swear}/
    end
  end

  def excludes_slurs?
    SLURS.none? do |slur|
      tweet.text =~ /#{slur}/
    end
  end

  def not_retweeted_old_school_style?
    tweet.text =~ /\A[^r][^t]/i
  end

end
