class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :subject
      t.text :description
      t.boolean :read, :default => false
      t.belongs_to :user

      t.timestamps
    end
  end
end
