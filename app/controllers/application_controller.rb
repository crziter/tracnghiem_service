class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token

  protected
  def return_obj(obj)
    respond_to do |format|
      format.json { render json: obj }
      format.json { render json: obj }
    end
  end
end
