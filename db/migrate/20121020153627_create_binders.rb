class CreateBinders < ActiveRecord::Migration
  def change
    create_table :binders do |t|
      t.string :name

      t.timestamps
    end
  end
end
