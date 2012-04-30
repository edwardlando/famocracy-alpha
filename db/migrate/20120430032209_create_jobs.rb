class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :description
      t.integer :pay
      t.date :due
      t.integer :employer_id
      t.integer :employee_id

      t.timestamps
    end
  end
end
