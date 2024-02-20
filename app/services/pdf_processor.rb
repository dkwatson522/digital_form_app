module PdfProcessor
  def self.extract_data(document)
    # Check if document has an attached file
    return unless document.pdf.attached?

    # Create a temporary file to read the PDF
    Tempfile.create(['temp_pdf', '.pdf'], binmode: true) do |tempfile|
      tempfile.write(document.pdf.download)
      tempfile.rewind
      # Initialize HexaPDF to read the tempfile
      pdf = HexaPDF::Document.open(tempfile.path)
      root_fields = pdf.acro_form&.root_fields || []
      data = {}

      root_fields.each do |field_ref|
        field = pdf.object(field_ref).value
        field_name = field[:T]&.gsub(' ', '_')&.downcase # Convert field name to snake case
        data[field_name] = field[:V] if field[:T] && field[:V]
      end

      document.update(data: data)
    end
  end
end
