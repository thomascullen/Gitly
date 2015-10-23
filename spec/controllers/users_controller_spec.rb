require 'rails_helper'

describe UsersController, type: :controller do
  let!(:user) { FactoryGirl.create :user, verified: false, active: false }

  describe '#validate' do
    it 'sets @users from an auth_token' do
      get :validate, auth_token: user.auth_token
      expect(assigns[:user]).to eq(user)
    end

    it 'verifys the user' do
      expect(user.verified).to eq(false)
      get :validate, auth_token: user.auth_token
      user.reload
      expect(user.verified).to be_truthy
    end

    it 'sets the user to active' do
      get :validate, auth_token: user.auth_token
      user.reload
      expect(user.active).to be_truthy
    end

    it 'renders the validate template' do
      get :validate, auth_token: user.auth_token
      expect(response).to render_template('validate')
    end
  end

  describe '#unsubscribe' do
    it 'sets @users from an auth_token' do
      get :unsubscribe, auth_token: user.auth_token
      expect(assigns[:user]).to eq(user)
    end

    it 'sets the user to inactive' do
      user.update_attributes(active: true)
      expect(user.active).to eq(true)
      get :unsubscribe, auth_token: user.auth_token
      user.reload
      expect(user.active).to eq(false)
    end

    it 'renders the unsubscribe template' do
      get :unsubscribe, auth_token: user.auth_token
      expect(response).to render_template('unsubscribe')
    end
  end
end
