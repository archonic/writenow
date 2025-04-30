class DocumentsController < ApplicationController
  before_action :set_document, only: %i[ show edit update destroy ]
  before_action :redirect_if_slug_historical, only: %i[ show edit update ]

  def index
    @documents = Document.all
    @document = Document.new
  end

  def show
  end

  def edit
  end

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

  # NOTE This is only for document settings
  def update
    respond_to do |format|
      if @document.update(update_params)
        notice = "Document was successfully updated."
        if @document.slug_previously_changed?
          format.html { redirect_to edit_document_path(@document), notice: }
        else
          format.turbo_stream { render turbo_stream: turbo_stream.replace(@document, Documents::Edit.new(model: @document)) }
          # format.turbo_stream { render turbostream: turbo_stream.replace(@document) }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

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
      params.require(:document).permit(:slug)
    end
end
