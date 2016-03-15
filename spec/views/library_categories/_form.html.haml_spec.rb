require 'rails_helper'

describe "library_categories/_form.html.haml", :type => :view do
  it 'fields' do
    test_manager = create(:manager)
    test_manager.organizations << test_manager.organization
    test_manager.organizations << create(:organization)
    test_manager.save!
    allow(controller).to receive(:current_user).and_return(test_manager)
    assign(:category, create(:library_category))
    render

    expect(rendered).to have_field('library_category_organization_id')
    expect(rendered).to have_field('library_category_name')
    expect(rendered).to have_field('library_category_description')
    expect(rendered).to have_field('library_category_public')
    expect(rendered).to have_field('library_category_active')
  end
end
