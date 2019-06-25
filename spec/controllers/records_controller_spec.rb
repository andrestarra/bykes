require 'rails_helper'

RSpec.describe RecordsController, type: :controller do
  let(:user) { create(:user) }
  let(:station) { create(:station) }
  let(:admin_station) { create(:admin_station) }

  describe '#index' do
    let(:bike) { create(:bike, station_id: station.id) }
    subject { get :index }

    context 'as an authorized user' do
      before do
        sign_in admin_station
        subject
      end

      it 'responds successfully' do
        aggregate_failures do
          expect(response).to be_successful
          expect(response).to have_http_status '200'
        end
      end

      it 'empty array where is no data' do
        expect(assigns(:records)).to be_empty
      end

      it 'assigns records array' do
        create_list(:bike, 10, station_id: station.id)
        rental_list = create_list(:rental, 10, station_id: station.id, user_id: user.id)
        rental_list.each { |rental| create(:record, rental_code: rental.code) }
        expect(assigns(:records).count).to eq 10
      end
    end

    context 'as an unauthorized user' do
      before { sign_in user }

      it 'access denied to an unauthorized user' do
        expect { get :index }
          .to raise_error(CanCan::AccessDenied)
      end
    end

    context 'as a guest' do
      before { subject }

      it { expect(response).to have_http_status '302' }
      it { expect(response). to redirect_to '/users/sign_in' }
    end
  end

  describe '#show' do
    let(:bike) { create(:bike, station_id: station.id) }
    let(:rental) { create(:rental, station_id: bike.station.id, user_id: user.id) }
    let(:record) { create(:record, rental_code: rental.code) }
    subject { get :show, params: { id: record.id } }

    context 'as an authorized user' do
      before do
        sign_in admin_station
        subject
      end

      it { expect(response).to be_successful }

      it 'with a nonexistent record id' do
        expect { get :show, params: { id: 500 } }
          .to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'as an unauthorized user' do
      before { sign_in user }

      it 'access denied to an unauthorized user' do
        expect { get :show, params: { id: record.id } }
          .to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe '#finalize' do
    let(:bike) { create(:bike, station_id: station.id) }
    let(:rental) { create(:rental, station_id: bike.station.id, user_id: user.id) }
    let(:record) { create(:record, rental_code: rental.code) }
    subject { patch :finalize, params: { id: record.id } }

    before do
      sign_in admin_station
      subject
    end

    it 'finalize a record' do
      expect(record.reload.state).to eq 'finished'
    end
  end

  describe '#new' do
    subject { get :new }

    before do
      sign_in admin_station
      subject
    end

    it { expect(response).to render_template(:new) }
    it { expect(assigns(:record)).to be_a_new(Record) }
  end

  describe '#create' do
    let(:bike) { create(:bike, station_id: station.id) }
    let(:rental) { create(:rental, station_id: bike.station.id, user_id: user.id) }
    let(:record_params) { attributes_for(:record, rental_code: rental.code) }
    let(:invalid_params) { attributes_for(:record, :invalid) }

    context 'as an authorized user' do
      before { sign_in admin_station }

      it 'adds a record' do
        expect { post :create, params: { record: record_params } }
          .to change(Record, :count).by(1)
      end

      it 'does not add a record' do
        expect { post :create, params: { record: invalid_params } }
          .to_not change(Record, :count)
      end
    end

    context 'as an unauthorized user' do
      before { sign_in user }

      it 'access denied to an unauthorized user' do
        expect { post :create, params: { record: record_params } }
          .to raise_error(CanCan::AccessDenied)
      end
    end

    context 'as a guest' do
      subject { post :create, params: { record: record_params } }
      before { subject }

      it { expect(response).to have_http_status '302' }
      it { expect(response).to redirect_to '/users/sign_in' }
    end
  end
end
