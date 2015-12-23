FactoryGirl.define do

  factory :library_document do
    association :library_category
    #association :creator, factory: :normal_user
    original_filename 'test_doc.pdf'
    description 'Test Document'
    file { Rack::Test::UploadedFile.new(File.join(TransamCore::Engine.root, 'spec', 'support', 'test_files', 'test_doc.pdf')) }
  end
end
