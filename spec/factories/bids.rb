FactoryGirl.define do
  factory :bid do
    association :auction, factory: :auction
    amount  200
  end

end
