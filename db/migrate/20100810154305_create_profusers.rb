class CreateProfusers < ActiveRecord::Migration
  def self.up
    create_table :profusers do |t|
      t.string :filename
      t.string :userid
      t.timestamps
    end
  end

  def self.down
    drop_table :profusers
  end
end
