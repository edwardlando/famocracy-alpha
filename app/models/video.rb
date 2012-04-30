class Video < ActiveRecord::Base
  # belongs_to :artist
  belongs_to :artist
  validates :title, :presence => true
  validates :link, :presence => true
end
