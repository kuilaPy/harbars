class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable
  has_many :orders
  has_one :cart
  has_many :reviews
  has_many :questions
  has_many :replies
  has_many :addresses



  validates :phone_number, presence: true, uniqueness: true ,length: { is: 10 }
  

end
