require 'rails_helper'

RSpec.describe GenresController, type: :controller do
  after(:each) { Genre.destroy_all }
  let(:genre) { Genre.create(name: 'comedy') }
  let(:genre2) { Genre.create(name: 'drama') }

  describe 'GET #index' do
    before(:each) { get :index }

    it 'assigns @genres' do
      expect(assigns(:genres)).to match([genre, genre2])
    end

    it 'renders index template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before(:each) { get :show, params: { id: genre.id } }

    it 'assigns @genre' do
      expect(assigns(:genre)).to eq genre
    end

    it 'renders show template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    before(:each) { get :edit, params: { id: genre.id } }

    it 'assigns @genre' do
      expect(assigns(:genre)).to eq Genre.last
    end

    it 'renderes edit template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:edit)
    end
  end

  describe 'GET #new' do
    before(:each) { get :new }

    it 'assigns empty genre' do
      expect(assigns(:genre)).to have_attributes(name: nil)
    end

    it 'renders new template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe 'DELETE #destoy' do
    it 'removes record' do
      genre
      amount_before = Genre.count

      delete :destroy, params: { id: genre.id }
      amount_after = Genre.count

      expect(amount_before).to eq amount_after + 1
    end
  end

  describe 'POST #create' do
    context 'when params are valid' do
      let(:params) { { genre: { name: 'foo'} } }

      it 'increases amount of records' do
        amount_before = Genre.count

        post :create, params: params
        amount_after = Genre.count

        expect(amount_before).to eq amount_after - 1
      end

      it 'redirects to genre' do
        post :create, params: params
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to genre_path(Genre.last)
      end
    end

    context 'when params are invalid' do
      let(:params) { { genre: { name: ''} } }

      it 'does not change amount of records' do
        amount_before = Genre.count

        post :create, params: params
        amount_after = Genre.count

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
      genre
      patch :update, params: params
    end

    context 'when params are valid' do
      let(:params) { { id: genre.id, genre: { name: 'foo' } } }

      it 'changes record' do
        expect(Genre.last.name).to eq 'foo'
      end

      it 'redirects to genre' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(genre)
      end
    end

    context 'when params are invalid' do
      let(:params) { { id: genre.id, genre: { name: '' } } }

      it 'does not change record' do
        expect(genre.name).to eq 'comedy'
      end

      it 'renders new template' do
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
      end
    end
  end
end
