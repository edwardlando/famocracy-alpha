class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.belongs_to :user
      t.integer :money
      t.integer :level

      t.timestamps
    end
    add_index :agents, :user_id
  end
end
