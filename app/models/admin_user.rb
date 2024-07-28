class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable
  
  has_many :replies


  ADMIN_EMAILS = ["avijitkuila5@gmail.com", "looserpro2024@gamil.com"]

end
