FactoryGirl.define do
  factory :bid do
      user
      auction
      bid { Faker::Number.decimal(2) }
    end
end
