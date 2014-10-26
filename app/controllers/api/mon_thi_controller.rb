class Api::MonThiController < ApplicationController
  def index
    @mon_thi = MonThi.all

    respond_to do |format|
      format.json { render json: @mon_thi }
      format.xml { render xml: @mon_thi }
    end
  end

  def create
    
  end
end
