class Binder < ActiveRecord::Base
  NAME_LENGTH_RANGE = 1..128

  attr_accessible :name

  validates :name,
    :presence => true,
    :format => { :with => /\A\w+\Z/ },
    :length => { :in => NAME_LENGTH_RANGE }

  has_many :documents
  has_many :holders
  has_many :users, :through => :holders
end
