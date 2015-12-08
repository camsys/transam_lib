CREATE TABLE library_categories (
	id                	int(11) AUTO_INCREMENT NOT NULL,
	object_key        	varchar(12) NOT NULL,
	organization_id			int(11) NOT NULL,
	name              	varchar(64) NOT NULL,
	description        	varchar(254) NOT NULL,
	active            	tinyint(1) NULL,
	created_at        	datetime NULL,
	updated_at        	datetime NULL,
	PRIMARY KEY(id)
)
GO
CREATE INDEX library_categories_idx1 USING BTREE
	ON library_categories(object_key)
GO

CREATE INDEX library_categories_idx2 USING BTREE
	ON library_categories(organization_id, name)
GO

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

CREATE INDEX library_documents_idx1 USING BTREE
	ON library_documents(object_key)
GO

CREATE INDEX library_documents_idx2 USING BTREE
	ON library_documents(library_category_id)
GO
