require 'rails_helper'

RSpec.describe ParseFormDataJob, type: :job do
  describe '#perform' do
    let(:document) { instance_double('Document') }

    before do
      allow(Document).to receive(:find).with(123).and_return(document)
      allow(PdfProcessor).to receive(:extract_data)
    end

    it 'finds the document and extracts data using PdfProcessor' do
      expect(Document).to receive(:find).with(123).and_return(document)
      expect(PdfProcessor).to receive(:extract_data).with(document)

      described_class.new.perform(123)
    end
  end
end
