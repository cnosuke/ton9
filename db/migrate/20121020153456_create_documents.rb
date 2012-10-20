class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.references :user
      t.references :binder

      t.timestamps
    end
    add_index :documents, :user_id
    add_index :documents, :binder_id
  end
end
