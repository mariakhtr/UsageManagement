class CreateFileuploads < ActiveRecord::Migration
  def self.up
    create_table :fileuploads do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :fileuploads
  end
end
