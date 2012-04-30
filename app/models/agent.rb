class Agent < ActiveRecord::Base
  belongs_to :user
  has_many :investments
end
