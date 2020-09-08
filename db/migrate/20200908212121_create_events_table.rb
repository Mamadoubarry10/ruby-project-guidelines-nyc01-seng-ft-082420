class CreateEventsTable < ActiveRecord::Migration[6.0]
  
  def change
    create_table :events do |t|
      t.string :name
      t.string :venue
      t.datetime :date
      t.float :price
      t.string :event_type
    end
  end
  
end
