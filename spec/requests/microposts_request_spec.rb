require 'rails_helper'

RSpec.describe '/microposts', type: :request do
  let(:user) { User.create!(name: 'test', email: 'test@test.com') }
  let(:valid_attributes) { { user_id: user.id, content: 'test' } }
  let(:invalid_attributes) { { user_id: user.id, content: 'a' * 141 } }

  describe 'GET /index' do
    it 'renders a successful response' do
      get microposts_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      micropost = Micropost.create! valid_attributes
      get micropost_url(micropost)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_micropost_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      micropost = Micropost.create! valid_attributes
      get edit_micropost_url(micropost)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Micropost' do
        expect do
          post microposts_url, params: { micropost: valid_attributes }
        end.to change(Micropost, :count).by(1)
      end

      it 'redirects to the created micropost' do
        post microposts_url, params: { micropost: valid_attributes }
        expect(response).to redirect_to(micropost_url(Micropost.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Micropost' do
        expect do
          post microposts_url, params: { micropost: invalid_attributes }
        end.to change(Micropost, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post microposts_url, params: { micropost: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { { content: 'content' } }

      it 'updates the requested micropost' do
        micropost = Micropost.create! valid_attributes
        expect do
          patch micropost_url(micropost), params: { micropost: new_attributes }
        end.to change { Micropost.find(micropost.id).content }.from(micropost.content).to(new_attributes[:content])
      end

      it 'redirects to the micropost' do
        micropost = Micropost.create! valid_attributes
        patch micropost_url(micropost), params: { micropost: new_attributes }
        micropost.reload
        expect(response).to redirect_to(micropost_url(micropost))
      end
    end

    context 'with invalid parameters' do
      let(:new_invalid_attributes) { { content: 'a' * 141 } }

      it "renders a successful response (i.e. to display the 'edit' template)" do
        micropost = Micropost.create! valid_attributes
        patch micropost_url(micropost), params: { micropost: new_invalid_attributes }
        expect(response).to be_successful
      end

      it 'does not updates the micropost infomation' do
        micropost = Micropost.create! valid_attributes
        expect do
          patch micropost_url(micropost), params: { micropost: new_invalid_attributes }
        end.not_to change(Micropost.find(micropost.id), :content)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested micropost' do
      micropost = Micropost.create! valid_attributes
      expect do
        delete micropost_url(micropost)
      end.to change(Micropost, :count).by(-1)
    end

    it 'redirects to the microposts list' do
      micropost = Micropost.create! valid_attributes
      delete micropost_url(micropost)
      expect(response).to redirect_to(microposts_url)
    end
  end
end
