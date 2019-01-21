class ApplicationController < ActionController::API
    def page_not_found
        render json: {:error => "page not found"}.to_json, :status => 404
    end
end
