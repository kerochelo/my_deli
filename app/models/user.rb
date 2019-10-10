# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name) UNIQUE
#

class User < ApplicationRecord
  has_secure_password
  has_many :favorite_article_relations
  has_many :fav_articles, through: :favorite_article_relations, source: :article
  validates :name,
    presence: true,
    uniqueness: true,
    length: {maximum: 16},
    format: {
      with: /\A[a-z0-9]+\z/,
      message: 'は小文字英数字で入力してください'
    }
  validates :password,
    length: {minimum: 8}

  # add to favorite articles
  def fav(article)
    favorite_article_relations.find_or_create_by(article_id: article.id)
  end

  # remove from favorite articles
  def unfav(article)
    favorite = favorite_article_relations.find_by(article_id: article.id)
    favorite.destroy if favorite
  end

  # check be added favorite articles
  def is_fav?(article)
    self.fav_articles.include?(article)
  end

end
