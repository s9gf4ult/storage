class CreateStorageItems < ActiveRecord::Migration
  def change
    create_table :storage_items do |t|
      t.integer :issue_id
      t.string :name
      t.decimal :cost, :precision => 15, :scale => 4
      t.integer :count
      t.datetime :production_time
    end
    add_index :storage_items, :issue_id
  end
end
