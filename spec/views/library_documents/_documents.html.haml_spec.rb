require 'rails_helper'

describe "library_documents/_documents.html.haml", :type => :view do
  it 'form' do
    allow(controller).to receive(:current_ability).and_return(Ability.new(create(:admin)))
    assign(:document, create(:library_document))
    render

    expect(rendered).to have_content('There is no supporting documentation for this document.')
    expect(rendered).to have_field('document_document')
    expect(rendered).to have_field('document_description')
  end
end
