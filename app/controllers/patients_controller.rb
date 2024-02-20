class PatientsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    patients
  end

  def show
    patient
  end

  def create
    patient = Patient.new(patient_params)
    if patient.save
      create_document(patient) if params[:patient][:document].present?
      render json: patient, status: :created
    else
      render json: patient.errors, status: :unprocessable_entity
    end
  end

  def update
    if patient.update(patient_params)
      render json: patient
    else
      render json: patient.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if patient.destroy
      head :no_content
    else
      render json: patient.errors, status: :unprocessable_entity
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:name, :date_of_birth, :street_address, :city, :state, :postal_code, :country, :d)
  end

  def patients
    @patients = Patient.includes(:documents).order(updated_at: :desc)
  end

  def patient
    @patient = Patient.includes(:documents).find(params[:id])
  end

  def create_document(patient)
    document = patient.documents.new(
      pdf: params[:patient][:document],
      name: params[:patient][:document].original_filename,
    )
    document.extension_type = extract_extension_type(document.name, params[:patient][:document].content_type)
    document.save
    ParseFormDataJob.perform_async(document.id)
  end

  def extract_extension_type(filename, content_type)
    if filename&.end_with?('.pdf') || content_type == 'application/pdf'
      'pdf'
    else
      'other'
    end
  end
end
