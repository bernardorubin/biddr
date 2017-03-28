FactoryGirl.define do
  factory :auction do
    user
    title { Faker::RockBand.name }
    description { Faker::Hipster.sentence }
    endson { Faker::Date.forward(23)  }
    reserveprice { Faker::Number.decimal(2) }
  end
end
