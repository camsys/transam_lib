require 'rails_helper'

RSpec.describe LibraryDocument, :type => :model do

  let(:test_doc) { create(:library_document) }

  describe 'associations' do
    it 'must have an org' do
      expect(LibraryDocument.column_names).to include('organization_id')
    end
    it 'must have a category' do
      expect(LibraryDocument.column_names).to include('library_category_id')
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
    it 'must have a user' do
      test_doc.user = nil

      expect(test_doc.valid?).to be false
    end
    it 'must have a file' do
      test_doc.file = nil

      expect(test_doc.valid?).to be false
    end
    it 'must have a original file name' do
      test_doc.original_filename = nil

      expect(test_doc.valid?).to be false
    end
  end

  it '#allowable_params' do
    expect(LibraryDocument.allowable_params).to eq([
      :organization_id,
      :library_category_id,
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
