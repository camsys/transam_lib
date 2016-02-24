class LibraryDocumentsController < OrganizationAwareController

  before_action :set_category
  before_action :set_document, :only => [:show, :edit, :update, :destroy, :download]

  def index
    @documents = @category.library_documents
  end

  def show
  end

  def new
    @document = LibraryDocument.new
  end

  def edit
  end

  def download

    # read the attachment
    content = open(@document.file.url, "User-Agent" => "Ruby/#{RUBY_VERSION}") {|f| f.read}
    # Send to the client
    send_data content, :filename => @document.original_filename

  end

  def create
    @document = @category.library_documents.build(document_params)
    @document.organization = @organization
    @document.creator = current_user

    respond_to do |format|
      if @document.save
        notify_user(:notice, 'Document was successfully created.')
        format.html { redirect_to :back }
        format.json { render action: 'show', status: :created, location: @document }
      else
        format.html { render action: 'new' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update

    respond_to do |format|
      if @document.update(document_params)
        notify_user(:notice, 'Document was successfully updated.')
        format.html { redirect_to library_category_library_document_path(@category, @document) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy

    @document.destroy

    notify_user(:notice, 'Document was successfully removed.')
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = LibraryCategory.find_by(:object_key => params[:library_category_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = LibraryDocument.find_by(:object_key => params[:id])
    if @document.nil?
      redirect_to '/404'
      return
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def document_params
    params.require(:library_document).permit(LibraryDocument.allowable_params)
  end

end
