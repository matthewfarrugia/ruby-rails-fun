# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# Sync the gifts table with this constant for this little test project
GIFTS = [
  {
    slug: "trip-to-iceland",
    name: "Our trip to Iceland",
    summary: "Contribute to our honeymoon in Iceland!",
    amount: 0,
    image: "iceland.jpeg",
    accepts_contributions: true
  },
  {
    slug: "hot-springs",
    name: "Hot springs trip",
    amount: 5000,
    image: "springs.webp"
  },
  {
    slug: "waterfalls",
    name: "A day trip to see the waterfalls",
    amount: 7000,
    image: "waterfalls.webp"
  },
  {
    slug: "jonsi-meet-and-greet",
    name: "Jónsi meet & greet",
    summary: "The man himself...",
    amount: 1200,
    image: "jonsi.jpg"
  },
  {
    slug: "soup-lunch",
    name: "Lunch in Reykjavík",
    amount: 2000,
    image: "soup.jpg"
  },
  {
    slug: "beers",
    name: "2x Icelandic beers",
    summary: "They can't grow hops up there!",
    amount: 20000,
    image: "beer.webp",
    accepts_contributions: true
  },
  {
    slug: "sauna-swim-beer",
    name: "Sauna, swim & beer",
    summary: "Warm up (then cool down) when we're back",
    amount: 10000,
    image: "sauna.jpg"
  },
  {
    slug: "dinner-in-brighton",
    name: "Dinner in Brighton",
    summary: "Lovely Jubbly",
    amount: 5000,
    image: "dinner.jpg"
  },
  {
    slug: "pancho-gift",
    name: "Gift for Pancho",
    summary: "The absolute vicar!",
    amount: 800,
    image: "pancho.jpeg"
  },
  {
    slug: "jerry-gift",
    name: "Gift for Jerry",
    summary: "An independent woman!",
    amount: 800,
    image: "jerry.jpeg"
  },
  {
    slug: "gift-for-both",
    name: "Gift for both of them!",
    amount: 1500,
    image: "cats.jpeg"
  }
]

GIFTS.each do |attributes|
  gift = Gift.find_or_initialize_by(slug: attributes[:slug])
  gift.config = {}
  gift.assign_attributes(attributes.except(:slug))
  gift.save!
end

Gift.where.not(slug: GIFTS.pluck(:slug)).delete_all

p "Updated gifts table with #{Gift.count} gift(s)"

contributor = Contributor.find_or_create_by!(email: "mitch.fablugia@example.com", name: "Mitch Fablugia")
p "Test user: #{contributor.email}"

if Contribution.count.zero?
  Contribution.create!(
    amount: 10000,
    currency: "GBP",
    contributor: contributor,
    gift: Gift.find("trip-to-iceland")
  )
  p "Seeded #{Contribution.count} test contribution(s)"
else
  p "Test contribution already seeded"
end
