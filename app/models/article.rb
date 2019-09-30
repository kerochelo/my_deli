# == Schema Information
#
# Table name: articles
#
#  id            :bigint           not null, primary key
#  body          :text(65535)
#  name          :string(255)
#  title         :string(255)      not null
#  url           :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  prefecture_id :integer
#

class Article < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :comments, dependent: :delete_all
  has_many :article_tag_relations, dependent: :delete_all
  has_many :tags, through: :article_tag_relations
  validates :name, length: {maximum: 30}
  validates :url, length: {maximum: 200}
  validates :title, presence: true, length: {maximum: 50}
  validates :body, length: {maximum: 1000}
end
