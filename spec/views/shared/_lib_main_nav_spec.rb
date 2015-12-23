require 'rails_helper'

describe "shared/_lib_main_nav.html.haml", :type => :view do
  it 'links' do
    test_category = create(:library_category)
    render

    expect(rendered).to have_link('Document Library')
    expect(rendered).to have_link(test_category.name)
  end
end
