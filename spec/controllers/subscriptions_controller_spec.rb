require 'rails_helper'

describe SubscriptionsController, type: :controller do
  let!(:user) { FactoryGirl.create :user }
  let!(:category) { FactoryGirl.create :category }

  describe '#new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe '#create' do
    it 'creates a new user if one does not already exist' do
      expect do
        post :create, email: 'user@example.com', categories: []
      end.to change { User.all.count }.by(1)
    end

    it 'can find an existing user' do
      post :create, email: user.email, categories: []
      expect(assigns[:user]).to eq(user)
    end

    it 'subscribes the user to an array of categories' do
      expect do
        post :create, email: user.email, categories: [category.id]
      end.to change(user.subscriptions, :count).by(1)
    end

    it 'should redirect to the root_path' do
      post :create, email: user.email, categories: []
      expect(response).to redirect_to(root_path)
    end
  end

  describe '#edit' do
    it 'sets @user from an auth_token' do
      get :edit, id: user.auth_token
      expect(assigns[:user]).to eq(user)
    end

    it 'redirects to the root_path if the user is not found' do
      get :edit, id: 'test'
      expect(response).to redirect_to root_path
    end
  end

  describe '#update' do
    it 'sets @user from an auth_token' do
      patch :update, auth_token: user.auth_token, categories: []
      expect(assigns[:user]).to eq(user)
    end

    it 'subscribes the user to an array of categories' do
      expect do
        patch :update, auth_token: user.auth_token, categories: [category.id]
      end.to change(user.subscriptions, :count).by(1)
    end
  end
end
