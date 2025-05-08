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
    @document.body = "<h1>#{create_params[:name]}</h1><p></p>"

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
    @document.update(update_params)
    render turbo_stream: turbo_stream.replace(@document, Documents::SettingsForm.new(model: @document, params:))
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
