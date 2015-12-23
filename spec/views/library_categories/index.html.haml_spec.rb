require 'rails_helper'

describe "library_categories/index.html.haml", :type => :view do
  it 'no catgories' do
    assign(:categories, [])
    render

    expect(rendered).to have_content('No matching documents found')
  end
end
