class Document < ActiveRecord::Base
  attr_accessible :title

  belongs_to :user
  belongs_to :binder
  has_many :items, class_name: "Item", foreign_key: "parent_document_id"
end