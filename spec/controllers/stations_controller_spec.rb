require 'rails_helper'

RSpec.describe StationsController, type: :controller do
  let(:user) { create(:user) }

  describe '#index' do
    subject { get :index }

    context 'as an authenticated user' do
      before do
        sign_in user
        subject
      end

      it 'responds successfully' do
        aggregate_failures do
          expect(response).to be_successful
          expect(response).to have_http_status '200'
        end
      end

      it 'empty array when there is no data' do
        expect(assigns(:stations)).to be_empty
      end

      it 'assigns stations array' do
        create_list(:station, 10)
        expect(assigns(:stations).count).to eq 10
      end
    end

    context 'as a guest' do
      before { subject }

      it { expect(response).to have_http_status '302' }
      it { expect(response).to redirect_to '/users/sign_in' }
    end
  end

  describe '#show' do
    let(:station) { create(:station) }
    
    subject { get :show, params: { id: station.id } }

    before do
      sign_in user
      subject
    end

    it 'responds successfully' do
      expect(response).to be_successful
    end

    it 'with a nonexistent station' do
      expect { get :show, params: { id: 500 } }
        .to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
