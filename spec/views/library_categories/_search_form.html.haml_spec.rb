require 'rails_helper'

describe "library_categories/_search_form.html.haml", :type => :view do
  it 'fields' do
    render

    expect(rendered).to have_field('search_text')
  end
end
