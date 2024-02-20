json.extract! patient, :id, :name, :date_of_birth
json.address do
  json.extract! patient, :street_address, :city, :state, :postal_code, :country
end
if patient.documents.present?
  json.documents do
    json.array! patient.documents, partial: "documents/document", as: :document
  end
end
