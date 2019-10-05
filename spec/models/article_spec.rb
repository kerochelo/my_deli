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
