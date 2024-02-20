require 'rails_helper'

RSpec.describe PdfProcessor do
  describe '.extract_data' do
    let(:document) { double('Document', pdf: pdf_attachment) }
    let(:pdf_attachment) { double('ActiveStorage::Attachment', attached?: attached, download: pdf_content) }
    let(:attached) { true }
    let(:pdf_content) { 'PDF content' }
    let(:tempfile) { Tempfile.new(['temp_pdf', '.pdf']) }
    let(:pdf_document) { instance_double('HexaPDF::Document', acro_form: acro_form) }
    let(:acro_form) { double('HexaPDF::Type::AcroForm', root_fields: root_fields) }
    let(:root_fields) { [{ T: 'Field1', V: 'Value1' }, { T: 'Field2', V: 'Value2' }] }

    before do
      allow(Tempfile).to receive(:create).and_yield(tempfile)
      allow(HexaPDF::Document).to receive(:open).and_return(pdf_document)
    end

    context 'when document has an attached PDF file' do
      before do
        allow(pdf_document).to receive(:object) do |field_ref|
          instance_double('HexaPDF::Object', value: root_fields.find { |field| field[:T] == field_ref[:T] })
        end
      end

      it 'extracts data from the PDF document' do
        expect(document).to receive_message_chain(:update).with(data: { 'field1' => 'Value1', 'field2' => 'Value2' })
        described_class.extract_data(document)
      end
    end

    context 'when document does not have an attached PDF file' do
      let(:attached) { false }

      it 'does not extract data' do
        expect(document).not_to receive(:update)
        described_class.extract_data(document)
      end
    end
  end
end
