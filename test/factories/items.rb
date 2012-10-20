# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    content "MyString"
    parent_item nil
    parent_document nil
  end
end
