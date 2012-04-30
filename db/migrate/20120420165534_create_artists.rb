class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.belongs_to :user
      t.integer :money
      t.integer :level

      t.timestamps
    end
    add_index :artists, :user_id
  end
end
