class Item < ActiveRecord::Base
  CONTENT_LENGTH_RANGE = 0..1024

  attr_accessible :content

  validates :content,
    :presence => true, :length => { :in => CONTENT_LENGTH_RANGE }

  belongs_to :parent_item, :class_name => "Item"
  belongs_to :parent_document, :class_name => "Document"
  has_many :child_items, :class_name => "Item", :foreign_key  => "parent_item_id"
end