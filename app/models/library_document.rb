#-------------------------------------------------------------------------------
# LibraryDocument
#
# Models a document uploaded into the TransAM document library
#-------------------------------------------------------------------------------
# Include the FileSizevalidator mixin
require 'file_size_validator'

class LibraryDocument < ActiveRecord::Base

  # From system config
  MAX_UPLOAD_FILE_SIZE = Rails.application.config.max_upload_file_size

  #-----------------------------------------------------------------------------
  # Behaviours
  #-----------------------------------------------------------------------------
  include TransamObjectKey

  #-----------------------------------------------------------------------------
  # Callbacks
  #-----------------------------------------------------------------------------
  after_initialize  :set_defaults

  #-----------------------------------------------------------------------------
  # Associations
  #-----------------------------------------------------------------------------
  # Every document belongs to an organization
  belongs_to :organization
  # Every document must belong to a category
  belongs_to :library_category

  # Has 0 or more comments. Using a polymorphic association, These will be removed if the project is removed
  has_many    :comments,    :as => :commentable,  :dependent => :destroy

  # uploader
  mount_uploader :file, LibraryUploader

  #------------------------------------------------------------------------------
  # Validations
  #------------------------------------------------------------------------------
  validates :name,                  :presence => true
  validates :description,           :presence => true
  validates :organization_id,       :presence => true
  validates :user_id,               :presence => true
  validates :file,                  :presence => true, :file_size => { :maximum => MAX_UPLOAD_FILE_SIZE.megabytes.to_i }
  validates :original_filename,     :presence => true

  #------------------------------------------------------------------------------
  # Scopes
  #------------------------------------------------------------------------------
  # default scope
  default_scope { order('created_at DESC') }

  # List of hash parameters allowed by the controller
  FORM_PARAMS = [
    :organization_id,
    :library_category_id,
    :name,
    :description,
    :file,
    :original_filename
  ]

  #-----------------------------------------------------------------------------
  # Class Methods
  #-----------------------------------------------------------------------------
  def self.allowable_params
    FORM_PARAMS
  end

  #-----------------------------------------------------------------------------
  # Instance Methods
  #-----------------------------------------------------------------------------
  def to_s
    name
  end

  #-----------------------------------------------------------------------------
  # Protected Methods
  #-----------------------------------------------------------------------------
  protected

  # Set resonable defaults for a new vehicle
  def set_defaults
  end

end
