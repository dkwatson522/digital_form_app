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
class Patient < ApplicationRecord
  has_many :documents
end
