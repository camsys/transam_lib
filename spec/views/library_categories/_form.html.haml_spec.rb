require 'rails_helper'

describe "library_categories/_form.html.haml", :type => :view do
  it 'fields' do
    assign(:category, create(:library_category))
    render

    expect(rendered).to have_field('library_category_name')
    expect(rendered).to have_field('library_category_description')
    expect(rendered).to have_field('library_category_active')
  end
end
