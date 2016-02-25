require 'rails_helper'

describe "library_documents/_comments.html.haml", :type => :view do
  it 'form' do
    allow(controller).to receive(:current_ability).and_return(Ability.new(create(:admin)))
    assign(:document, create(:library_document))
    render

    expect(rendered).to have_content('There are no comments for this document.')
    expect(rendered).to have_field('comment_comment')
  end
end
