class Document < ActiveRecord::Base
  MAX_TITLE_RANGE = 1..128

  attr_accessible :title

  validates :title,
    :presence => true,
    :inclusion => { :in => MAX_TITLE_RANGE }


  belongs_to :user
  belongs_to :binder
  has_many :items, class_name: "Item", foreign_key: "parent_document_id"
end