#-------------------------------------------------------------------------------
# LibraryCategory
#
# User-defined category for organizing library documents.
#-------------------------------------------------------------------------------
class LibraryCategory < ActiveRecord::Base

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
  # Every category belongs to an organization
  belongs_to :organization
  # Every category has 0 or more documents
  has_many    :library_documents, :dependent => :destroy

  #------------------------------------------------------------------------------
  # Validations
  #------------------------------------------------------------------------------
  validates :name,                  :presence => true
  validates :description,           :presence => true
  #If this is public is cannot explicitly belong to an organization so it will be null otherwise it should be something.
  #validates :organization_id,       :presence => true, unless: :public


  #------------------------------------------------------------------------------
  # Scopes
  #------------------------------------------------------------------------------
  scope :active, -> { where(:active => true) }

  FORM_PARAMS = [
    :organization_id,
    :name,
    :description,
    :public,
    :active
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

  # Returns true if category can be deleted
  def deleteable?
    library_documents.empty?
  end

  def is_public?
    (public)
  end

  #-----------------------------------------------------------------------------
  # Protected Methods
  #-----------------------------------------------------------------------------
  protected

  # Set resonable defaults for a new library category
  def set_defaults
    self.active = self.active.nil? ? true : self.active
    self.public = self.public.nil? ? false : self.public
  end

end
