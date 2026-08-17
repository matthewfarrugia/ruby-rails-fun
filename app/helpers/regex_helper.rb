module RegexHelper
  public
  TITLE_FORMAT = /\A[^\r\n]+\z/
  SLUG_FORMAT = /\A[a-z0-9\-_.]+\z/
  CURRENCY_FORMAT = /\A[A-Z]{3}\z/ # @todo can't do this in real life
end
