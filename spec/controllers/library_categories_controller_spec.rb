require 'rails_helper'

RSpec.describe LibraryCategoriesController, :type => :controller do

  let(:test_category) { create(:library_category) }

  before(:each) do
    sign_in create(:admin)
  end

  it 'GET index' do
    test_category.update!(:organization => subject.current_user.organization)
    get :index, :org_filter => subject.current_user.organization.id, :library_category_id => test_category.id

    expect(assigns(:categories)).to include(test_category)
  end

  it 'GET show' do
    get :show, :id => test_category.object_key

    expect(assigns(:category)).to eq(test_category)
  end

  it 'GET new' do
    get :new

    expect(assigns(:category).to_json).to eq(LibraryCategory.new.to_json)
  end

  it 'GET edit' do
    get :edit, :id => test_category.object_key

    expect(assigns(:category)).to eq(test_category)
  end

  it 'POST create' do
    LibraryCategory.destroy_all
    post :create, :library_category => attributes_for(:library_category, :organization_id => subject.current_user.organization.id)

    expect(LibraryCategory.count).to eq(1)
    expect(LibraryCategory.first.organization).to eq(subject.current_user.organization)
  end

  it 'PUT update' do
    put :update, :id => test_category.object_key, :library_category => {:description => 'new description'}
    test_category.reload

    expect(test_category.description).to eq('new description')
  end

  it 'DELETE destroy' do
    delete :destroy, :id => test_category.object_key

    expect(LibraryCategory.find_by(:object_key => test_category.object_key)).to be nil
  end

  describe 'negative tests' do
    it 'no category' do
      get :show, :id => 'ABCDEFGHIJKL'

      expect(assigns(:category)).to be nil
      expect(response).to redirect_to('/404')
    end
  end

end
