require 'rails_helper'

describe "library_documents/_summary.html.haml", :type => :view do
  it 'form' do
    test_doc = create(:library_document)
    render 'library_documents/summary', :document => test_doc

    expect(rendered).to have_content(test_doc.name)
    expect(rendered).to have_content(test_doc.description)
    expect(rendered).to have_content(test_doc.original_filename)
    expect(rendered).to have_content(test_doc.creator.to_s)
  end
end
