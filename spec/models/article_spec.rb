# == Schema Information
#
# Table name: articles
#
#  id            :bigint           not null, primary key
#  address       :string(255)
#  body          :text(65535)
#  latitude      :float(24)
#  longitude     :float(24)
#  name          :string(255)
#  title         :string(255)      not null
#  url           :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  prefecture_id :integer
#

require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @article = Article.new
  end

  describe 'validation' do
    it 'valid title' do
      @article.title = ''
      expect(@article.valid?).to eq(false)
    end

    it 'right title' do
      @article.title = 'abcd'
      expect(@article.valid?).to eq(true)
    end
  end
end
