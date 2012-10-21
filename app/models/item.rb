class Item < ActiveRecord::Base
  attr_accessible :content

  belongs_to :parent_item, :class_name => "Item"
  belongs_to :parent_document, :class_name => "Document"
  has_many :child_items, :class_name => "Item", :foreign_key  => "parent_item_id"
end