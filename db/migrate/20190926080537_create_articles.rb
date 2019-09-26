class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :name
      t.string :title, null: false
      t.string :url
      t.text :body
      t.integer :area_id

      t.timestamps
    end
  end
end
