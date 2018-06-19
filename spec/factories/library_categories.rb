FactoryBot.define do

  factory :library_category do
    association :organization
    name 'Test Library Category'
    description 'test library category description'
    active true
  end
end
