class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable
  
  has_many :replies


  ADMIN_EMAILS = ["chandraherbals51@gmail.com", "looserpro2024@gmail.com"]

end
