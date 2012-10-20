class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :content
      t.references :parent_item
      t.references :parent_document

      t.timestamps
    end
    add_index :items, :parent_item_id
    add_index :items, :parent_document_id
  end
end
