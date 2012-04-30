class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title, :null => false
      t.string :link, :null => false
      t.integer :views, :default => 0
      t.belongs_to :artist

      t.timestamps
    end
  end
end
