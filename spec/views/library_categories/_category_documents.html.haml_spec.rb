require 'rails_helper'

describe "library_categories/_category_documents.html.haml", :type => :view do
  it 'file' do
    allow(controller).to receive(:current_ability).and_return(Ability.new(create(:admin)))
    test_category = create(:library_category)
    test_doc = create(:library_document, :library_category => test_category)
    render 'library_categories/category_documents', :category => test_category

    expect(rendered).to have_link(test_doc.name)
    expect(rendered).to have_link('Download')
    expect(rendered).to have_link('Edit')
    expect(rendered).to have_link('Delete')
  end
end
