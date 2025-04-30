# frozen_string_literal: true

module API
  class DocumentsController < ActionController::API
    # Authenticate the call with a header bearer token or something like that
    # Want to be sure this comes from our app

    # Where's my routes annotation?
    def autosave
      @document = Document.find_by(token: params[:id])
      body = autosave_params[:body]
      name = Nokogiri::HTML5.fragment(body[0..108]).css("h1")&.first&.text
      @document.update({ name:, body: }.compact)

      # Respond with 204 No Content regardless of success
      head :no_content
    end

    private

    def autosave_params
      params.require(:document).permit(:body)
    end
  end
end
