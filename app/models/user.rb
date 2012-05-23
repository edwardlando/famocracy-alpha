class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation,
    :remember_me, :agent, :artist
  
  validates :name, :presence => true
  validates :email, :uniqueness => {:case_sensitve => false}
  
  has_one :artist
  has_one :agent
  has_many :notifications
  
  def artist?
    !artist.nil?
  end
  
  def agent?
    !agent.nil?
  end
  
  def specific
    if artist?
      artist
    else
      agent
    end
  end
end
