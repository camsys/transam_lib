require 'rails_helper'

RSpec.describe LibraryDocument, :type => :model do

  let(:test_doc) { create(:library_document) }

  describe 'associations' do
    it 'must have an org' do
      expect(test_doc).to belong_to(:organization)
    end
    it 'must have a category' do
      expect(test_doc).to belong_to(:library_category)
    end
  end
  describe 'validations' do
    it 'must have a name' do
      test_doc.name = nil

      expect(test_doc.valid?).to be false
    end
    it 'must have a description' do
      test_doc.description = nil

      expect(test_doc.valid?).to be false
    end
    it 'must have an organization' do
      test_doc.organization = nil

      expect(test_doc.valid?).to be false
    end
    it 'must have a creator' do
      test_doc.creator = nil

      expect(test_doc.valid?).to be false
    end
    it 'must have a file' do
      test_doc = build_stubbed(:library_document, :file => nil)

      expect(test_doc.valid?).to be false
    end
    it 'must have a original file name' do
      test_doc.original_filename = nil

      expect(test_doc.valid?).to be false
    end
  end

  it '#allowable_params' do
    expect(LibraryDocument.allowable_params).to eq([
      :name,
      :description,
      :file,
      :original_filename
    ])
  end

  it '.to_s' do
    expect(test_doc.to_s).to eq(test_doc.name)
  end
end
