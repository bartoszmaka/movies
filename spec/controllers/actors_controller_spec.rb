require 'rails_helper'

RSpec.describe ActorsController, type: :controller do
  after(:each) { Actor.destroy_all }
  let(:actor) { Actor.create(first_name: 'Bob', last_name: 'Rails') }
  let(:actor2) { Actor.create(first_name: 'Jim', last_name: 'Ruby') }

  describe 'GET #index' do
    before(:each) { get :index }

    it 'assigns @actors' do
      expect(assigns(:actors)).to match([actor, actor2])
    end

    it 'renders index template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before(:each) { get :show, params: { id: actor.id } }

    it 'assigns @actor' do
      expect(assigns(:actor)).to eq actor
    end

    it 'renders show template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    before(:each) { get :edit, params: { id: actor.id } }

    it 'assigns @actor' do
      expect(assigns(:actor)).to eq Actor.last
    end

    it 'renderes edit template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:edit)
    end
  end

  describe 'GET #new' do
    before(:each) { get :new }

    it 'assigns empty actor' do
      expect(assigns(:actor)).to have_attributes(first_name: nil, last_name: nil)
    end

    it 'renders new template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe 'DELETE #destoy' do
    it 'removes record' do
      actor
      amount_before = Actor.count

      delete :destroy, params: { id: actor.id }
      amount_after = Actor.count

      expect(amount_before).to eq amount_after + 1
    end
  end

  describe 'POST #create' do
    context 'when params are valid' do
      let(:params) { { actor: { first_name: 'Foo', last_name: 'Bar' } } }

      it 'increases amount of records' do
        amount_before = Actor.count

        post :create, params: params
        amount_after = Actor.count

        expect(amount_before).to eq amount_after - 1
      end

      it 'redirects to actor' do
        post :create, params: params
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to actor_path(Actor.last)
      end
    end

    context 'when params are invalid' do
      let(:params) { { actor: { first_name: 'Foo', last_name: '' } } }

      it 'does not change amount of records' do
        amount_before = Actor.count

        post :create, params: params
        amount_after = Actor.count

        expect(amount_before).to eq amount_after

      end

      it 'renders new template' do
        post :create, params: params
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    before(:each) do
      actor
      patch :update, params: params
    end

    context 'when params are valid' do
      let(:params) { { id: actor.id, actor: { first_name: 'Foo' } } }

      it 'changes record' do
        expect(Actor.last.first_name).to eq 'Foo'
      end

      it 'redirects to actor' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(actor)
      end
    end

    context 'when params are invalid' do
      let(:params) { { id: actor.id, actor: { first_name: '' } } }

      it 'does not change record' do
        expect(actor.first_name).to eq 'Bob'
      end

      it 'renders new template' do
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
      end
    end
  end
end
