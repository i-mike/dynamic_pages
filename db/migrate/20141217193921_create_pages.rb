class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :slug,       null: false, default: ""
      t.integer :priority
      t.boolean :enabled,   null: false, default: false
      t.integer :parent_id

      t.timestamps
    end
    add_index :pages, :slug, unique: true
    add_index :pages, :parent_id
  end
end
