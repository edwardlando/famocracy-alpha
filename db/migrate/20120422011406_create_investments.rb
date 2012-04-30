class CreateInvestments < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.belongs_to :artist
      t.belongs_to :agent
      t.integer :amount
      t.date :invested

      t.timestamps
    end
    add_index :investments, :artist_id
    add_index :investments, :agent_id
  end
end
