FactoryBot.define do
  factory :vacation do
    start_date { Faker::Date.between(from: '2014-09-23', to: '2023-02-25')}
    finish_date { Faker::Date.between(from: '2014-09-23', to: '2023-02-25') }
    employee 
  end

  factory :employee do
    name { Faker::Name.name }
    position { Faker::Company.profession }
    admission_date { Faker::Date.between(from: '2014-09-23', to: '2023-02-25')  }
  end
end