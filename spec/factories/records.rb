FactoryBot.define do
  factory :record do
    date { Faker::Date.in_date_period }
    memo                 { Faker::Lorem.sentence }
    subject_id           { Faker::Number.within(range: 0..18) }
    price                { Faker::Number.number(digits: 5) }
    detail               { Faker::Lorem.sentence }
    user                 { FactoryBot.create(:user) }
  end
end
