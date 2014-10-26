class Api::MonThiController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @mon_thi = MonThi.all

    respond_to do |format|
      format.json { render json: @mon_thi }
      format.xml { render xml: @mon_thi }
    end
  end

  def create
    begin
      information = request.raw_post
      mon_thi = JSON.parse(information)
      ten_mon_thi = mon_thi['ten']

      if ten_mon_thi != nil
        mt = MonThi.new
        mt.ten=ten_mon_thi
        mt.save

        return_obj :status => 'Ok', :inserted_id => mt.id
      else
        return_obj :status => 'Invalid MonThi object'
      end
    rescue
      return_obj :status => 'Invalid json'
    end
  end

  private
  def return_obj(obj)
    respond_to do |format|
      format.json { render json: obj }
      format.json { render json: obj }
    end
  end
end
