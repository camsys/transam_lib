class RemoveNotNullContraintOnOrganizationIdInLibraryDocuments < ActiveRecord::Migration
  def change
    change_column_null :library_documents, :organization_id, true
  end
end
