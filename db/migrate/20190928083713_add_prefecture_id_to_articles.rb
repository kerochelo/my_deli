class AddPrefectureIdToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :prefecture_id, :integer
  end
end
