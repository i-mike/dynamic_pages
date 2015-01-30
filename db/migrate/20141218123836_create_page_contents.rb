class CreatePageContents < ActiveRecord::Migration
  def change
    create_table :page_contents do |t|
      t.string :title
      t.text :body
      t.references :language, index: true
      t.references :page, index: true

      t.timestamps
    end
  end
end
