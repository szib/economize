require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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

  describe 'GET :new' do
    it 'responds to html by default' do
      get :new
      expect(response.content_type).to eq 'text/html'
    end
  end

  describe 'POST :create' do
    it 'create a user' do
      users = User.all.count
      get :create, user: valid_attributes
      expect(User.all.count).to eq(users + 1)
    end

    xit 'redirects to user show' do
      get :create, valid_attributes
      expect(response).to redirect_to(user_path(1))
    end
  end
end
