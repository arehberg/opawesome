# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :opawesome_test_option, :class => 'Opawesome::TestOption' do
    test_id 1
    value "MyString"
  end
end
