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
  before_save       :update_file_attributes

  #-----------------------------------------------------------------------------
  # Associations
  #-----------------------------------------------------------------------------
  # Every document belongs to an organization
  belongs_to :organization
  # Every document must belong to a category
  belongs_to :library_category

  belongs_to :creator, -> { unscope(where: :active) }, :class_name => "User", :foreign_key => "created_by_id"

  # Has 0 or more comments. Using a polymorphic association, These will be removed if the project is removed
  has_many    :comments,    :as => :commentable,  :dependent => :destroy

  # Has 0 or more documents. Using a polymorphic association, These will be removed if the project is removed
  has_many    :documents,    :as => :documentable,  :dependent => :destroy

  # uploader
  mount_uploader :file, LibraryUploader

  #------------------------------------------------------------------------------
  # Validations
  #------------------------------------------------------------------------------
  validates :name,                  :presence => true
  validates :description,           :presence => true
  validates :organization_id,       :presence => true,
            unless: Proc.new { |l| l.library_category.public } # public libraryr categories don't have an organization id and neither do their docs.
  validates :creator,               :presence => true
  validates :file,                  :presence => true, :file_size => { :maximum => MAX_UPLOAD_FILE_SIZE.megabytes.to_i }
  validates :original_filename,     :presence => true

  #------------------------------------------------------------------------------
  # Scopes
  #------------------------------------------------------------------------------
  # default scope
  default_scope { order('created_at DESC') }

  # List of hash parameters allowed by the controller
  FORM_PARAMS = [
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

  #-----------------------------------------------------------------------------
  #
  # Private Methods
  #
  #-----------------------------------------------------------------------------
  private

  def update_file_attributes

    if file.present? && file_changed?
      self.content_type = file.file.content_type
      self.file_size = file.file.size
    end
  end

end
