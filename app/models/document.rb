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
class Document < ApplicationRecord
  enum extension_type: { other: 0, pdf: 1 }

  belongs_to :patient
  has_one_attached :pdf
end
