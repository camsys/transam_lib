require 'rails_helper'

describe "library_documents/_form.html.haml", :type => :view do
  it 'fields' do
    assign(:category, create(:library_category))
    assign(:document, LibraryDocument.new)
    render

    expect(rendered).to have_field('library_document_name')
    expect(rendered).to have_field('library_document_description')
    expect(rendered).to have_field('library_document_file')
  end
end
