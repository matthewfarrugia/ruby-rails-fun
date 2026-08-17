class Contribution < ApplicationRecord
  validates :amount,
            presence: true,
            numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10_000_000 }
  validates :currency,
            presence: true,
            format: { with: RegexHelper::CURRENCY_FORMAT }
  validates :contributor,
            presence: true
  validates :gift,
            presence: true

  belongs_to :gift, primary_key: "slug"
  belongs_to :contributor
  # broadcasts_to ->(_gift) { "gifts" }, inserts_by: :append, target: "gifts"
end
