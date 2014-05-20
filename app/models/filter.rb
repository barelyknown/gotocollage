class Filter
  SWEARS = %w(shit fuck ass dick cunt pussy)
  SLURS = %w(fag gay homo nigga nigger nig bitch twat)

  attr_reader :tweet

  def initialize(tweet)
    @tweet = tweet
  end

  def filter?
    return true unless includes_exact_phrase?
    return true unless non_reply?
    return true unless excludes_profanity?
    return true unless not_retweeted_old_school_style?
    return true unless not_quoted?
    false
  end

  def includes_exact_phrase?
    tweet.text =~ /go to collage/i
  end

  def non_reply?
    tweet.text =~ /\A[^@]/
  end

  def excludes_profanity?
    (SWEARS + SLURS).none? do |profanity|
      [tweet.text, tweet.user.name, tweet.user.screen_name].none? do |attribute|
        attribute =~ /#{profanity}/i
      end
    end
  end

  def not_retweeted_old_school_style?
    tweet.text =~ /\A[^r][^t]/i
  end

  def not_quoted?
    tweet.text =~/\A[^'"“]/
  end

end
