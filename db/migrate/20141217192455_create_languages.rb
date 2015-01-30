class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :slug, null: false, default: ""
      t.string :name, null: false, default: ""

      t.timestamps
    end
    add_index :languages, :slug, unique: true
  end
end
