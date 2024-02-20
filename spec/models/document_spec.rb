# == Schema Information
#
# Table name: documents
#
#  id             :bigint           not null, primary key
#  data           :jsonb            not null
#  extension_type :integer          default("other"), not null
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  patient_id     :bigint           not null
#
# Indexes
#
#  index_documents_on_patient_id  (patient_id)
#
# Foreign Keys
#
#  fk_rails_...  (patient_id => patients.id)
#
require 'rails_helper'

RSpec.describe Document, type: :model do
  describe 'validations' do
    let(:document) { described_class.create(patient: patient) }
    let(:patient) { Patient.create(name: Faker::Name) }

    it 'is valid with valid attributes' do
      document.pdf.attach(io: File.open(Rails.root.join('spec/fixtures/test.pdf')), filename: 'test.pdf', content_type: 'application/pdf')
      expect(document).to be_valid
    end
  end
end
