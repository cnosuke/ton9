# coding: utf-8
FactoryGirl.define do
  factory :user do
    name "user"
    icon nil
  end

  factory :document do
    title "title"
    user
    binder
  end

  factory :item do
    content "content"
    parent_document FactoryGirl.build(:document)
    parent_item     FactoryGirl.build(:item)
  end

  factory :binder do
    name "binder"
  end

  factory :holder do
    binder
    user
  end
end