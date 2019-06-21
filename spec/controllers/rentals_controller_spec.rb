require 'rails_helper'

RSpec.describe RentalsController, type: :controller do
  let(:user) { create(:user) }
  let(:station) { create(:station) }
  let(:bike) { create(:bike, station_id: station.id) }

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

      it 'empty arrat when there is no data' do
        expect(assigns(:rentals)).to be_empty
      end

      it 'assigns rentals array' do
        create_list(:rental, 10, user_id: user.id)
        expect(assigns(:rentals).count).to eq 10
      end
    end

    context 'as a guest' do
      before { subject }

      it { expect(response).to have_http_status '302' }
      it { expect(response). to redirect_to '/users/sign_in' }
    end
  end

  describe '#show' do
    let(:rental) { create(:rental, user_id: user.id, station_id: station.id) }
    subject { get :show, params: { station_id: rental.station_id, id: rental.id } }

    context 'as an authorized user' do
      before do
        sign_in user
        subject
      end

      it 'responds successfully' do
        expect(response).to be_successful
      end

      it 'with a nonexistent rental id' do
        expect { get :show, params: { station_id: rental.station_id, id: 500 } }
          .to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'as an unauthorized user' do
      let(:other_user) { create(:user) }
      before do
        sign_in other_user
      end

      it 'record not found to an unauthorized user' do
        expect { get :show, params: { station_id: rental.station_id, id: rental.id } }
          .to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#new' do
    subject { get :new, params: { station_id: station.id } }

    before do
      sign_in user
      subject
    end

    it { expect(response).to render_template(:new) }
    it { expect(assigns(:rental)).to be_a_new(Rental) }
  end

  describe '#create' do
    let(:rental_params) { attributes_for(:rental, user_id: user.id) }
    let(:invalid_params) { attributes_for(:rental, :invalid, user_id: user.id) }

    context 'as an authenticated user' do
      before { sign_in user }

      it 'adds a rental' do
        expect { post :create, params: { station_id: station.id, rental: rental_params } }
          .to change(user.rentals, :count).by(1)
      end

      it 'does not add a rental' do
        expect { post :create, params: { station_id: station.id, rental: invalid_params } }
          .to_not change(user.rentals, :count)
      end
    end

    context 'as a guest' do
      subject { post :create, params: { station_id: station.id, rental: rental_params } }
      before { subject }

      it { expect(response).to have_http_status '302' }
      it { expect(response).to redirect_to '/users/sign_in' }
    end
  end
end
