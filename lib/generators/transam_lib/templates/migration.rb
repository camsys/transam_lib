class CreateTransamLibTables < ActiveRecord::Migration

  def self.up

    create_table :library_categories do |t|
      t.string  :object_key,          :limit => 12,   :null => false
      t.integer :organization_id,                     :null => false
      t.string  :name,                :limit => 64,   :null => false
      t.string  :description,         :limit => 254,  :null => false
      t.boolean :active,                              :null => false
      t.timestamps
    end

    add_index     :library_categories, [:object_key],       :name => :library_categories_idx1
    add_index     :library_categories, [:organization_id],  :name => :library_categories_idx2
    add_index     :library_categories, [:active],           :name => :library_categories_idx3

    CREATE TABLE library_documents (
    	id                   	int(11) AUTO_INCREMENT NOT NULL,
    	object_key        		varchar(12) NOT NULL,
    	library_category_id		int(11) NOT NULL,
    	file                  varchar(128) NOT NULL,
    	description        		varchar(254) NOT NULL,
    	original_filename			varchar(128) NOT NULL,
    	content_type     			varchar(128) NOT NULL,
    	file_size        			int(11) NOT NULL,
    	created_by_id    			int(11) NOT NULL,
    	created_at       			datetime NULL,
    	updated_at       			datetime NULL,
    	PRIMARY KEY(id)
    )
    GO

    create_table :library_documents do |t|
      t.string    :object_key,          :limit => 12,   :null => false
      t.integer   :library_category_id,                 :null => false
      t.string    :file,                :limit => 128,  :null => false
      t.string    :description,         :limit => 254,  :null => false
      t.string    :original_filename,   :limit => 128,  :null => false
      t.string    :content_type,        :limit => 128,  :null => false
      t.integer   :file_size,                           :null => false
      t.integer   :created_by_id,                       :null => false
      t.boolean   :active,                              :null => false
      t.timestamps
    end

    add_index     :library_documents, [:object_key],          :name => :library_documents_idx1
    add_index     :library_documents, [:library_category_id], :name => :library_documents_idx2
    add_index     :library_documents, [:active],              :name => :library_documents_idx3

  end

  def self.down
    drop_table :library_categories
    drop_table :library_documents
  end

end
