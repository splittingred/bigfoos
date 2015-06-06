require 'spec_helper'

describe GamesController do
  before do
    create_and_sign_in_user
  end

  describe '#index' do
    it 'show index page' do
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
      expect(assigns(:games)).to_not be_nil
    end
  end

  describe '#new' do
    it 'test new page' do
      get :new
      expect(response).to be_success
      expect(assigns(:game)).to_not be_nil

      expect(response).to render_template(:new)
    end
  end

  describe '#edit' do
    it 'test get edit page' do
      game = create :game

      get :edit, id: game
      expect(response).to be_success
      expect(response).to render_template(:edit)
      expect(assigns(:game)).to_not be_nil
      expect(assigns(:users)).to_not be_nil
    end

    it 'test failure for edit page with invalid ID' do
      get :edit, id: 'not_found'
      expect(response).to be_redirect
      expect(response).to redirect_to action: :index
      expect(flash[:error]).to eq 'Game not found'
    end
  end
end
