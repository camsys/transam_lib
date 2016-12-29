#-----------------------------------------------------------------------------
# LibraryCategoriesController
#
#-----------------------------------------------------------------------------
class LibraryCategoriesController < OrganizationAwareController

  authorize_resource :except => [:destroy]

  INDEX_KEY_LIST_VAR        = "library_key_list_cache_var"

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Document Library", :library_categories_path

  before_action :set_category, only: [:show, :edit, :update, :destroy, :load_view]

  #-----------------------------------------------------------------------------
  # Library and search interface
  #-----------------------------------------------------------------------------
  def index

     # Start to set up the query
    conditions  = []
    values      = []

    # Check to see if we got an organization to sub select on.
    @org_filter = params[:org_filter]

    # ignore organization list and get all public categories as well
    conditions << '(public = 1 OR library_categories.organization_id IN (?))'
    if @org_filter.blank?
      values << @organization_list
    else
      values << @org_filter
    end

    @library_category_id = params[:library_category_id]
    unless @library_category_id.blank?
      conditions << 'library_categories.id = ?'
      values << @library_category_id
    end

    @search_text = params[:search_text]
    unless @search_text.blank?
      conditions << '(library_categories.name LIKE ? OR library_categories.description LIKE ? OR library_documents.name LIKE ? OR library_documents.description LIKE ?)'
      query_str = '%' + @search_text + '%'
      values << query_str
      values << query_str
      values << query_str
      values << query_str
    end

    #puts conditions.inspect
    #puts values.inspect

    @categories = LibraryCategory.includes(:library_documents).where(conditions.join(' AND '), *values).references(:library_documents).order("public desc", :name)

    # cache the set of object keys in case we need them later
    cache_list(@categories, INDEX_KEY_LIST_VAR)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @categories }
      format.xls
    end
  end

  #-----------------------------------------------------------------------------
  # Show documents in a library category
  #-----------------------------------------------------------------------------
  def show

    add_breadcrumb @category.name, library_category_path(@category)

    # get the @prev_record_path and @next_record_path view vars
    get_next_and_prev_object_keys(@category, INDEX_KEY_LIST_VAR)
    @prev_record_path = @prev_record_key.nil? ? "#" : library_category_path(@prev_record_key)
    @next_record_path = @next_record_key.nil? ? "#" : library_category_path(@next_record_key)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @category }
    end
  end

  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def new

    add_breadcrumb "New", new_library_category_path

    @category = LibraryCategory.new

  end

  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def edit

    add_breadcrumb @category.name, library_category_path(@category)
    add_breadcrumb "Modify"

  end

  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def create

    add_breadcrumb "New", new_library_category_path

    @category = LibraryCategory.new(form_params)
    if @category.organization.nil? && !@category.public
      @category.organization_id = @organization_list.first
    end

    respond_to do |format|
      if @category.save
        notify_user(:notice, "Library category #{@category} was successfully created.")
        format.html { redirect_to library_category_path(@category) }
        format.json { render :json => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.json { render :json => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def update

    add_breadcrumb @category.name, library_category_path(@category)
    add_breadcrumb "Modify"

    respond_to do |format|
      if @category.update_attributes(form_params)
        notify_user(:notice, "Library category #{@category.name} was successfully updated.")
        format.html { redirect_to library_category_path(@category) }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def destroy

    authorize! :destroy, @category

    @category.destroy
    notify_user(:notice, "Library Category was successfully removed.")
    respond_to do |format|
      format.html { redirect_to library_categories_path }
      format.json { head :no_content }
    end
  end

  #-----------------------------------------------------------------------------
  # Generic AJAX method for displaying a regular or modal view
  #-----------------------------------------------------------------------------
  def load_view

    render params[:view]

  end

  protected


  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def form_params
    params.require(:library_category).permit(LibraryCategory.allowable_params)
  end

  def set_category
    @category = LibraryCategory.find_by(:object_key => params[:id])
    if @category.nil?
      redirect_to '/404'
      return
    end
  end

end
