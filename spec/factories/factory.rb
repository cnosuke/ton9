# coding: utf-8
require 'factory_girl'

FactoryGirl.define do
  factory :user do
    name "user"
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

  factory :master_item, class: Item do
    content "content"
    parent_document_id FactoryGirl.build(:document).id
    parent_item_id     nil
  end

  factory :member_item, class: Item do
    content "content"
    parent_document_id nil
    parent_item_id     FactoryGirl.build(:master_item).id
  end

  factory :holder do
    binder
    user
  end
end
