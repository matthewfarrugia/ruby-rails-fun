class Contributor < ApplicationRecord
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name,
            presence: true,
            length: { minimum: 3, maximum: 255 },
            format: { with: RegexHelper::TITLE_FORMAT, message: "may not contain line breaks" }

  normalizes :email, with: ->(email) { email.strip.downcase }
  normalizes :name, with: ->(name) { name.strip }

  scope :alphabetical, -> { order(:email) }

  # broadcasts_to ->(_contributor) { "contributors" }, inserts_by: :append, target: "contributors"
end
