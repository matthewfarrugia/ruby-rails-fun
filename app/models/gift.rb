class Gift < ApplicationRecord
  self.primary_key = "slug"

  store_accessor :config, :image, :accepts_contributions
  monetize :amount_cents

  has_many :contributions, dependent: :delete_all
  has_many :contributors, through: :contributions

  validates :slug,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 100 },
            format: { with: RegexHelper::SLUG_FORMAT, message: "may only contain lowercase letters, numbers, underscores, dashes, and dots" }
  validates :name,
            presence: true,
            length: { minimum: 3, maximum: 255 },
            format: { with: RegexHelper::TITLE_FORMAT, message: "may not contain line breaks" }
  validates :summary, length: { maximum: 255 }

  normalizes :slug, with: ->(slug) { slug.strip.downcase }
  normalizes :name, with: ->(name) { name.strip }
  normalizes :summary, with: ->(summary) { summary.strip }

  scope :alphabetical, -> { order(:name) }

  # broadcasts_to ->(_gift) { "gifts" }, inserts_by: :append, target: "gifts"
end
