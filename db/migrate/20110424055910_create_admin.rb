class CreateAdmin < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
      t.string :username
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.timestamps
    end


    add_column :users, :admin_id, :integer  
  end

  def self.down
    drop_table :admins
    drop_column :users, :admin_id
  end
end
