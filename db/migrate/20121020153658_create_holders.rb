class CreateHolders < ActiveRecord::Migration
  def change
    create_table :holders do |t|
      t.references :user
      t.references :binder

      t.timestamps
    end
    add_index :holders, :user_id
    add_index :holders, :binder_id
  end
end
