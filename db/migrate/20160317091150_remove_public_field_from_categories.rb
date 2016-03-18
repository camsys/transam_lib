class AddPublicFieldToCategories < ActiveRecord::Migration
  def change
    remove_column :library_categories, :public, :boolean, :after => :description
  end
end
