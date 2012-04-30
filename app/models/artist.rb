class Artist < ActiveRecord::Base
  belongs_to :user
  has_many :videos
  has_many :investments
end
