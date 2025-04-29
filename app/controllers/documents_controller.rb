class DocumentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[ autosave ]
  before_action :set_document, only: %i[ show edit update destroy ]
  before_action :redirect_if_slug_historical, only: %i[ show edit update ]

  # GET /documents
  def index
    @documents = Document.all
    @document = Document.new
  end

  # GET /documents/1
  def show
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  def create
    @document = Document.new(create_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to edit_document_path(@document), status: :see_other, notice: "Document successfully created." }
      else
        format.turbo_stream
      end
    end
  end

  # PATCH/PUT /documents/1
  def update
    respond_to do |format|
      if @document.update(update_params)
        format.html { redirect_to @document, notice: "Document was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # Consider seperating this into an API controller. Yes that's a good idea.
  # POST /documents/:id/autosave, but :id is :token
  def autosave
    @document = Document.find_by(token: params[:id])
    @document.update(body: autosave_params[:body])
    p @document.body
    # Respond with 204 No Content regardless of success
    head :no_content
  end

  # DELETE /documents/1
  def destroy
    @document.destroy!

    respond_to do |format|
      format.html { redirect_to documents_path, status: :see_other, notice: "Document was successfully destroyed." }
    end
  end

  private
    def set_document
      @document = Document.friendly.find(params.expect(:id))
    end

    def redirect_if_slug_historical
      if params.expect(:id) != @document.slug
        redirect_to @document, status: :moved_permanently
      end
    end

    def create_params
      # We accept token here because it would otherwise be regenerated upon edit, which nukes the document
      params.require(:document).permit(:name, :token)
    end

    def update_params
      params.require(:document).permit(:name, :slug)
    end

    def autosave_params
      params.require(:document).permit(:body)
    end
end
