class CreateUsersTable < ActiveRecord::Migration[6.0]
  
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :password
      t.string :city
    end
  end
end
