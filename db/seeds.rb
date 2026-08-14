# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

GIFTS = [
  { slug: "trip-to-iceland", name: "Our trip to Iceland", summary: "Contribute to our honeymoon in Iceland!", contribution: true, amount: 0 },
  { slug: "trip-to-iceland333", name: "Our trip to Iceland", summary: "Contribute to our honeymoon in Iceland!", contribution: false, amount: 10000 },
]

GIFTS.each do |attributes|
  Gift.find_or_create_by!(slug: attributes[:slug]) do |gift|
    gift.slug         = attributes[:slug]
    gift.name         = attributes[:name]
    gift.summary      = attributes[:summary]
    gift.contribution = attributes[:contribution]
    gift.amount       = attributes[:amount]
    gift.save
  end
end

p "Seeded #{Gift.count} gift(s)"

Contributor.find_or_create_by!(email: "mitch.fablugia@example.com", name: "Mitch Fablugia") do |contributor|
  p "Test user: #{contributor.email}"
  if Contribution.count == 0
    Contribution.create({
      amount: 10000,
      currency: "GBP",
      contributor: contributor,
      gift: Gift.find("trip-to-iceland")
    })
    p "Seeded #{Contribution.count} test contribution(s)"
  else
    p "Test contribution already seeded"
  end
end

