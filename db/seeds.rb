# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Find or create a user to be the "logged-in" user
user = User.find_by!(email: "kubotaren5213@docomo.ne.jp") 
  
# Create some travel plans and tasks associated with this user
20.times do |index|
  travel_plan = user.travel_plans.create!(
    title: "タイトル#{index}", 
    note: "本文#{index}",
    due: Faker::Date.forward(days: 60)  # Set a due date in the future
  )

  20.times do
    travel_plan.tasks.create!(
      title: Faker::Lorem.sentence(word_count: 3),  # Random task title
      body: Faker::Lorem.paragraph,                 # Random task body
      status: %w[pending working done].sample,      # Random status
      baggage: %w[carry leave].sample,              # Random baggage
      due: Faker::Date.forward(days: 30),           # Random due date
      user: user
    )
  end
end
