require 'rails_helper'

RSpec.describe User, type: :model do
  valid_attributes = {
    first_name: 'Arya',
    last_name: 'Stark',
    email: 'arya@winterfell.no',
    password: 'foobar',
    password_confirmation: 'foobar'
  }

  before :each do
    @user = User.new(valid_attributes)
  end

  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end

  describe ':first_name' do
    it 'invalid if nil' do
      @user.first_name = nil
      expect(@user).to_not be_valid
    end
    it 'invalid if empty' do
      @user.first_name = ''
      expect(@user).to_not be_valid
    end
  end

  describe ':last_name' do
    it 'invalid if nil' do
      @user.last_name = nil
      expect(@user).to_not be_valid
    end
    it 'invalid if empty' do
      @user.last_name = ''
      expect(@user).to_not be_valid
    end
  end

  describe ':email' do
    it 'invalid if nil' do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it 'invalid if empty' do
      @user.email = ''
      expect(@user).to_not be_valid
    end

    it 'invalid if email address has invalid format' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |email|
        @user.email = email
        expect(@user).to_not be_valid
      end
    end

    it 'is unique' do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      expect(duplicate_user).to_not be_valid
    end
  end

  describe ':password' do
    it 'is invalid if blank' do
      @user.password = @user.password_confirmation = ' ' * 6
      expect(@user).to_not be_valid
    end

    it 'is invalid if too short' do
      @user.password = @user.password_confirmation = 'fooba'
      expect(@user).to_not be_valid
    end

    it 'is invalid if confirmation does not match' do
      @user.password_confirmation = 'fooba'
      expect(@user).to_not be_valid
    end

    it 'is valid if confirmation is nil' do
      @user.password_confirmation = nil
      expect(@user).to be_valid
    end

  end
end
