class AddPublicFieldToCategories < ActiveRecord::Migration
  def change
    add_column    :library_categories, :public, :boolean, :after => :description
  end
end
