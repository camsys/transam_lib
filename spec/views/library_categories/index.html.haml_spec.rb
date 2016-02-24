require 'rails_helper'

describe "library_categories/index.html.haml", :type => :view do
  it 'no catgories' do
    allow(controller).to receive(:current_ability).and_return(Ability.new(create(:admin)))
    assign(:categories, [])
    render

    expect(rendered).to have_content('No matching documents found')
  end
end
