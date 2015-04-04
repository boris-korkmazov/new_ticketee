class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :user_id
      t.references :thing, polymorphic: true
      t.string :action

      t.timestamps null: false
    end
  end
end
