class Job < ActiveRecord::Base
  validates :description, :presence => true
  validates :pay, :presence => true
  validates_numericality_of :pay, :integer_only => true, :greater_than => 0
end
