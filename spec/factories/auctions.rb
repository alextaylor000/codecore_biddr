FactoryGirl.define do
  factory :auction do
    title             Faker::Lorem.sentence
    details           Faker::Lorem.paragraph
    ends_on           5.days.from_now
    reserve_price     100
  end

end
