require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  after(:each) { Movie.destroy_all }
  let(:genre) { Genre.create(name: 'test') }
  let(:movie) { Movie.create(name: 'The RSpec', revenue: 123, genre: genre) }
  let(:movie2) { Movie.create(name: 'The RSpec In Space', revenue: 543, genre: genre) }

  describe 'GET #index' do
    before(:each) { get :index }

    it 'assigns @movies' do
      expect(assigns(:movies)).to match([movie, movie2])
    end

    it 'renders index template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before(:each) { get :show, params: { id: movie.id } }

    it 'assigns @movie' do
      expect(assigns(:movie)).to eq movie
    end

    it 'renders show template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    before(:each) { get :edit, params: { id: movie.id } }

    it 'assigns @movie' do
      expect(assigns(:movie)).to eq Movie.last
    end

    it 'renderes edit template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:edit)
    end
  end

  describe 'GET #new' do
    before(:each) { get :new }

    it 'assigns empty movie' do
      expect(assigns(:movie)).to have_attributes(name: nil)
    end

    it 'renders new template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe 'DELETE #destoy' do
    it 'removes record' do
      movie
      amount_before = Movie.count

      delete :destroy, params: { id: movie.id }
      amount_after = Movie.count

      expect(amount_before).to eq amount_after + 1
    end
  end

  describe 'POST #create' do
    context 'when params are valid' do
      let(:params) { { movie: { name: 'foo', revenue: 234, genre_name: genre.name } } }

      it 'increases amount of records' do
        amount_before = Movie.count

        post :create, params: params
        amount_after = Movie.count

        expect(amount_before).to eq amount_after - 1
      end

      it 'redirects to movie' do
        post :create, params: params
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to movie_path(Movie.last)
      end
    end

    context 'when params are invalid' do
      let(:params) { { movie: { name: '', revenue: 234} } }

      it 'does not change amount of records' do
        amount_before = Movie.count

        post :create, params: params
        amount_after = Movie.count

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
      movie
      patch :update, params: params
    end

    context 'when params are valid' do
      let(:params) { { id: movie.id, movie: { name: 'foo', revenue: 234 } } }

      it 'changes record' do
        expect(Movie.last.name).to eq 'foo'
      end

      it 'redirects to movie' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(movie)
      end
    end

    context 'when params are invalid' do
      let(:params) { { id: movie.id, movie: { name: '', revenue: 234 } } }

      it 'does not change record' do
        expect(movie.name).to eq 'The RSpec'
      end

      it 'renders new template' do
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
      end
    end
  end
end
