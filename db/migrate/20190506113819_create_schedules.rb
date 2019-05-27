class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.references :user, foreign_key: true
      t.datetime :start
      t.string :kind
      t.string :place
      t.integer :publicflag
      t.string :content
      t.integer :capacity
      t.datetime :deadline

      t.timestamps
    end
  end
end
