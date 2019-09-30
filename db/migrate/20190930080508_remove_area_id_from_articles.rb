class RemoveAreaIdFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :area_id, :integer
  end
end
