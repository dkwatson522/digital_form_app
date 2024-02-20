# spec/routing/documents_routing_spec.rb
require 'rails_helper'

RSpec.describe 'DocumentsController', type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/patients/1/documents').to route_to('documents#index', patient_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/patients/1/documents/2').to route_to('documents#show', patient_id: '1', id: '2')
    end

    it 'routes to #create' do
      expect(post: '/patients/1/documents').to route_to('documents#create', patient_id: '1')
    end

    it 'routes to #update' do
      expect(put: '/patients/1/documents/2').to route_to('documents#update', patient_id: '1', id: '2')
    end

    it 'routes to #destroy' do
      expect(delete: '/patients/1/documents/2').to route_to('documents#destroy', patient_id: '1', id: '2')
    end
  end
end
