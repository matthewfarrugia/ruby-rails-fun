class Contribution < ApplicationRecord
  validates :amount,
            presence: true,
            length: { min: 1, maximum: 100000 }
  # validates :currency,
  #           presence: true,
  #           format: { with: /\A[A-Z]{3}\z/i },
  validates :contributor,
            presence: true
  validates :gift,
            presence: true

  scope :amount, ->(a, b) { b <=> a } # descending

  belongs_to :gift, primary_key: "slug"
  belongs_to :contributor
  # broadcasts_to ->(_gift) { "gifts" }, inserts_by: :append, target: "gifts"
end
