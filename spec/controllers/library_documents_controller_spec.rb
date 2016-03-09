require 'rails_helper'

RSpec.describe LibraryDocumentsController, :type => :controller do

  let(:test_category) { create(:library_category) }
  let(:test_doc) { create(:library_document, :library_category => test_category) }

  before(:each) do
    sign_in create(:admin)
  end

  it 'GET index' do
    test_doc.save!
    get :index, :library_category_id => test_category.object_key

    expect(assigns(:category)).to eq(test_category)
    expect(assigns(:documents)).to eq(test_category.library_documents)
  end
  it 'GET show' do
    get :show, :library_category_id => test_category.object_key, :id => test_doc.object_key

    expect(assigns(:category)).to eq(test_category)
    expect(assigns(:document)).to eq(test_doc)
  end

  it 'GET new' do
    get :new, :library_category_id => test_category.object_key

    expect(assigns(:category)).to eq(test_category)
    expect(assigns(:document).to_json).to eq(LibraryDocument.new.to_json)
  end
  it 'GET edit' do
    get :edit, :library_category_id => test_category.object_key, :id => test_doc.object_key

    expect(assigns(:category)).to eq(test_category)
    expect(assigns(:document)).to eq(test_doc)
  end

  it 'POST create' do
    post :create, :library_category_id => test_category.object_key, :library_document => attributes_for(:library_document, :description => 'new description 222')
    test_category.reload

    expect(assigns(:category)).to eq(test_category)
    expect(test_category.library_documents.count).to eq(1)
    expect(test_category.library_documents.first.description).to eq('new description 222')
  end
  it 'PUT update' do
    put :update, :library_category_id => test_category.object_key, :id => test_doc.object_key, :library_document => {:description => 'new description 222'}
    test_doc.reload

    expect(assigns(:category)).to eq(test_category)
    expect(assigns(:document)).to eq(test_doc)
    expect(test_doc.description).to eq('new description 222')
  end

  it 'DELETE destroy' do
    request.env["HTTP_REFERER"] = root_path
    delete :destroy, :library_category_id => test_category.object_key, :id => test_doc.object_key

    expect(assigns(:category)).to eq(test_category)
    expect(LibraryDocument.find_by(:object_key => test_doc.object_key)).to be nil
  end

end
