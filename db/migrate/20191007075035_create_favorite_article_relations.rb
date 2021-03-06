class CreateFavoriteArticleRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_article_relations do |t|
      t.references :user, foreign_key: true
      t.references :article, foreign_key: true

      t.timestamps
      t.index [:user_id, :article_id], unique: true
    end
  end
end
