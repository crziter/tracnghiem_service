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

        return_obj :status => :ok, :id => mt.id
      else
        return_obj :status => :fail, :reason => 'invalid MonThi object'
      end
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end

  def destroy
    begin
      mt_id = params[:id]
      @mt = MonThi.where(id: mt_id).first

      if @mt == nil
        raise 'Id not found'
      end

      @mt.destroy

      return_obj :status => :ok, :id => @mt.id
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end
end
