class ContributionForm
  include ActiveModel::Model

  attr_accessor :gift, :name, :email, :amount, :currency

  validates :gift, presence: true
  validates :name, length: { minimum: 3, maximum: 255 }, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true
  validates :amount, numericality: { greater_than: 0, less_than_or_equal_to: 10_000_000 }
  validates :currency, presence: true, inclusion: { in: Money::Currency.table.keys.map(&:to_s) }

  def save
    return false unless valid?
    ActiveRecord::Base.transaction do
      contributor = Contributor.find_or_create_by!(email: email.strip.downcase) do |c|
        c.name = name
      end

      Contribution.create!(
        gift: gift,
        contributor: contributor,
        amount: Money.new(amount, currency)
      )
    end

    true
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, "There was an error saving your contribution. Please try again.")
    errors.merge!(e.record.errors)
    false
  end
end
