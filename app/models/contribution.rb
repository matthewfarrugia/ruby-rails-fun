class Contribution < ApplicationRecord
  monetize :amount_cents,
           presence: true,
           numericality: { greater_than: 0, less_than_or_equal_to: 10_000_000 }
  validates :contributor,
            presence: true
  validates :gift,
            presence: true

  belongs_to :gift, primary_key: "slug"
  belongs_to :contributor
  # broadcasts_to ->(_gift) { "gifts" }, inserts_by: :append, target: "gifts"
end
