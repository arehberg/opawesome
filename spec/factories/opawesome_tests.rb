# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :opawesome_test, class: 'Opawesome::Test' do
    sequence(:key){ |n| "test_key#{n}" }
    name "Test Name"
  end
end
