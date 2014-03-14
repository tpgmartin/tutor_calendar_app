class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.date :date
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
