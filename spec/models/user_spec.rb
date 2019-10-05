require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = User.new
  end

  describe 'validation' do
    it 'invalid empty name' do
      @user.name = ''
      @user.password_digest = 'abcdefghij'
      expect(@user.valid?).to eq(false)
    end

    it 'invalid long name length' do
      @user.name = 'abcdefghij123456789'
      @user.password_digest = 'abcdefghij'
      expect(@user.valid?).to eq(false)
    end

    it 'invalid name' do
      @user.name = 'abcd--1234'
      @user.password_digest = 'abcdefghij'
      expect(@user.valid?).to eq(false)
    end

    it 'invalid empty password_digest' do
      @user.name = 'name'
      @user.password_digest = ''
      expect(@user.valid?).to eq(false)
    end

    it 'invalid short password_digest' do
      @user.name = 'name'
      @user.password_digest = 'abc123'
      expect(@user.valid?).to eq(false)
    end
  end
end
