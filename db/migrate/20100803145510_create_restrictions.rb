class CreateRestrictions < ActiveRecord::Migration
  def self.up
    create_table :restrictions do |t|
      t.string :resname
      t.string :userid
      t.string :rescondition
      t.string :function, :default => "Equatable" 
      t.timestamps
    end
  end

  def self.down
    drop_table :restrictions
  end
end
