class User < ActiveRecord::Base
  has_many :wikis, dependent: :destroy
  
  after_initialize { self.role ||= :standard }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  
  enum role: [:standard, :admin, :premium]
  

 
         
end

