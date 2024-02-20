# == Schema Information
#
# Table name: patients
#
#  id             :bigint           not null, primary key
#  city           :string
#  country        :string
#  date_of_birth  :date
#  name           :string
#  postal_code    :string
#  state          :string
#  street_address :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Patient do
  it "has many documents" do
    patient = Patient.new
    expect(patient).to respond_to(:documents)
  end
end
