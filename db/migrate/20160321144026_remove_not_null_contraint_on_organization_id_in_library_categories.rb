class RemoveNotNullContraintOnOrganizationIdInLibraryCategories < ActiveRecord::Migration
  def change
    change_column_null :library_categories, :organization_id, true
  end
end
