# coding: utf-8
require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "user#{n}"}
    sequence(:email) {|n| "a#{n}@example.com"}
    password "hogehoge"
  end

  factory :binder do
    name "binder"
  end

  factory :document do
    title "title"
    user
    binder
  end

  factory :item do
    content "content"
    parent_document_id nil
    parent_item_id     nil
  end

  factory :holder do
    binder
    user
  end
end
