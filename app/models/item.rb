class Item < ActiveRecord::Base
  belongs_to :parent_item
  belongs_to :parent_document
  attr_accessible :content
end
