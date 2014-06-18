# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title "MyString"
    body "MyText"
    published false
    published_at "2014-06-17 10:17:54"
    unpublished_at "2014-06-17 10:17:54"
  end
end
