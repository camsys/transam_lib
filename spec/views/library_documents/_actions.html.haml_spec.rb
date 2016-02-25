require 'rails_helper'

describe "library_documents/_actions.html.haml", :type => :view do
  it 'links' do
    allow(controller).to receive(:current_ability).and_return(Ability.new(create(:admin)))
    assign(:document, create(:library_document))
    render

    expect(rendered).to have_link('Download this document')
    expect(rendered).to have_link('Update this document')
    expect(rendered).to have_link('Remove this document')
  end
end
