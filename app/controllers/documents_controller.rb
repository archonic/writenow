class DocumentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[ autosave ]
  before_action :set_document, only: %i[ show edit update destroy ]
  before_action :redirect_if_slug_historical, only: %i[ show edit update ]

  # GET /documents or /documents.json
  def index
    @documents = Document.all
  end

  # GET /documents/1 or /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents or /documents.json
  def create
    @document = Document.new(create_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: "Document was successfully created." }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1 or /documents/1.json
  def update
    respond_to do |format|
      if @document.update(update_params)
        format.html { redirect_to @document, notice: "Document was successfully updated." }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
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

  # DELETE /documents/1 or /documents/1.json
  def destroy
    @document.destroy!

    respond_to do |format|
      format.html { redirect_to documents_path, status: :see_other, notice: "Document was successfully destroyed." }
      format.json { head :no_content }
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
