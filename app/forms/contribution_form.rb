class ContributionForm
  include ActiveModel::Model

  attr_accessor :gift, :name, :email, :amount, :currency

  validates :gift, presence: true
  validates :name, length: { minimum: 3, maximum: 255 }, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true
  validates :amount, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10_000_000 } # in pennies right now

  validates :currency, format: { with: /\AGBP\z/ }, presence: true # @todo: currently just a hidden field

  def save
    return false unless valid?
    ActiveRecord::Base.transaction do
      contributor = Contributor.find_or_create_by!(email: email.strip.downcase) do |c|
        c.name = name
      end

      Contribution.create!(
        gift: gift,
        contributor: contributor,
        amount: amount,
        currency: currency
      )
    end

    true
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, "There was an error saving your contribution. Please try again.")
    errors.merge!(e.record.errors)
    false
  end
end
