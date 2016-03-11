require 'rails_helper'

describe "library_categories/_actions.html.haml", :type => :view do
  it 'links' do
    allow(controller).to receive(:current_ability).and_return(Ability.new(create(:admin)))
    render 'library_categories/actions', :category => create(:library_category)

    expect(rendered).to have_link('Add document to category')
    expect(rendered).to have_link('Update this category')
    expect(rendered).to have_link('Remove this category')
  end
end
