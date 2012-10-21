class Binder < ActiveRecord::Base
  NAME_LENGTH_RANGE = 1..128

  attr_accessible :name

  validates :name,
    :presence => true,
    :inclusion => { :in => NAME_LENGTH_RANGE }

  has_many :documents
  has_many :holders
  has_many :users, :through => :holders
end
