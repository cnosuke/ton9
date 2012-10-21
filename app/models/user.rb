class User < ActiveRecord::Base
  #定数
  NAME_LENGTH_RANGE = 1..128

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name

  validates :name,
    :presence => true,
    :uniqueness => true,
    :format => { :with => /\A\w+\Z/ },
    :length => { :in => NAME_LENGTH_RANGE}
  validates :email,
    :presence => true,
    :uniqueness => true,
    :email => true
  #パスワードはdevise側でチェックされる

  has_many :documents
  has_many :holders
  has_many :binders, :through => :holders
end
