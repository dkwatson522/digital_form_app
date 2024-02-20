class DocumentsController < ApplicationController
  before_action :set_patient
  before_action :set_document, only: %i[show update destroy]
  skip_before_action :verify_authenticity_token

  def index
    @documents = @patient.documents
    render json: {documents: @documents, patient: @patient}
  end

  def show
    render json: {document: @document, patient: @patient}
  end

  def create
    @document = @patient.documents.new(document_params)
    if @document.save
      # Trigger job to process the document
      ParseFormDataJob.perform_async(@document.id)
      render json: @document, status: :created
    else
      render json: @document.errors, status: :unprocessable_entity
    end
  end

  def update
    if @document.update(document_params)
      render json: @document
    else
      render json: @document.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @document.destroy
    head :no_content
  end

  private

  def set_patient
    @patient = Patient.find(params[:patient_id])
  end

  def set_document
    @document = @patient.documents.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:pdf, :name, :extension_type, :data)
  end
end
