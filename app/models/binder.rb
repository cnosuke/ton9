class Binder < ActiveRecord::Base
  attr_accessible :name

  has_many :documents
  has_many :holders
  has_many :users, :through => :holders
end
