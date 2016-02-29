require 'rails_helper'

RSpec.describe LibraryCategory, :type => :model do

  let(:test_category) { create(:library_category) }

  describe 'associations' do
    it 'has an org' do
      expect(test_category).to belong_to(:organization)
    end
  end

  describe 'validations' do
    it 'must have a name' do
      test_category.name = nil

      expect(test_category.valid?).to be false
    end
    it 'must have a description' do
      test_category.description = nil

      expect(test_category.valid?).to be false
    end
    it 'must have an org' do
      test_category.organization = nil

      expect(test_category.valid?).to be false
    end
  end

  it '#allowable_params' do
    expect(LibraryCategory.allowable_params).to eq([
      :organization_id,
      :name,
      :description,
      :active
    ])
  end

  it '.to_s' do
    expect(test_category.to_s).to eq(test_category.name)
  end

  it '.deleteable?' do
    expect(test_category.deleteable?).to be true
    create(:library_document, :library_category => test_category)
    expect(test_category.deleteable?).to be false
  end
end
