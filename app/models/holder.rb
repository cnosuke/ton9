class Holder < ActiveRecord::Base
  belongs_to :user
  belongs_to :binder
  # attr_accessible :title, :body
end
