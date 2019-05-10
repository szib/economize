require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET :new' do
    it 'responds to html by default' do
      get :new
      expect(response.content_type).to eq 'text/html'
    end
  end
end
