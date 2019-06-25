require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'flash class' do
    it 'notice flash' do
      expect(helper.flash_class('notice')).to eq('alert alert-info')
    end

    it 'success flash' do
      expect(helper.flash_class('success')).to eq('alert alert-success')
    end

    it 'error flash' do
      expect(helper.flash_class('error')).to eq('alert alert-danger')
    end

    it 'alert flash' do
      expect(helper.flash_class('alert')).to eq('alert alert-warning')
    end
  end
end
