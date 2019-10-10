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
