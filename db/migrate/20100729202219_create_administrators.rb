class CreateAdministrators < ActiveRecord::Migration
  def self.up
    create_table :administrators do |t|
      t.string :name
      t.string :password
      t.string :fname
      t.string :lname
      t.string :email
      t.timestamps
    end
  end

  def self.down
    drop_table :administrators
  end
end
