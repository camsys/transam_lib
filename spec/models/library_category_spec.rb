require 'rails_helper'

RSpec.describe LibraryCategory, :type => :model do

  let(:test_category) { create(:library_category) }

  describe 'associations' do
    it 'has an org' do
      expect(LibraryCategory.column_names).to include('organization_id')
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

  end

  it '.to_s' do
    expect(test_category.to_s).to eq(test_category.name)
  end
end
