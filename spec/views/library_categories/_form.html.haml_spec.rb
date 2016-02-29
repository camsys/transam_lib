require 'rails_helper'

describe "library_categories/_form.html.haml", :type => :view do
  it 'fields' do
    assign(:category, create(:library_category))
    assign(:organization_list, [1,2])
    render

    expect(rendered).to have_field('library_category_organization_id')
    expect(rendered).to have_field('library_category_name')
    expect(rendered).to have_field('library_category_description')
    expect(rendered).to have_field('library_category_active')
  end
end
