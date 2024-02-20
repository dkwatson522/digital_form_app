class ParseFormDataJob
  include Sidekiq::Job

  def perform(file_id)
    document = Document.find(file_id)
    PdfProcessor.extract_data(document)
  end
end
