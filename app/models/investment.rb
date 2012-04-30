class Investment < ActiveRecord::Base
  belongs_to :artist
  belongs_to :agent
end
