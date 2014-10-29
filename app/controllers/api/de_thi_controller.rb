class Api::DeThiController < ApplicationController
  def index
    @dts = DeThi.all
    return_obj @dts
  end

  def create
    begin
      dt_json = JSON.parse(request.raw_post)
      mt = MonThi.where(id: dt_json['mon_thi_id']).first
      if mt == nil
        raise 'MonThi id not found'
      end

      @dt = DeThi.new
      @dt.mon_thi = mt
      @dt.save

      return_obj :status => :ok, :id => @dt.id
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end

  def list_by_mon_thi
    begin
      mt_id = params[:id]
      @dts = DeThi.where(mon_thi_id: mt_id)
      if @dts == nil
        raise 'MonThi id not found'
      end

      return_obj @dts
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end

  def add_cau_hoi
    begin
      obj_json = JSON.parse(request.raw_post)
      dt_id = obj_json['de_thi_id']
      ch_id = obj_json['cau_hoi_id']

      if dt_id == nil || ch_id == nil
        raise 'Json invalid'
      end

      ch = CauHoi.where(id: ch_id).first
      dt = DeThi.where(id: dt_id).first

      if ch == nil || dt == nil
        raise 'CauHoi or DeThi not found'
      end

      dt_ch = DeThiCauHoi.new
      dt_ch.cau_hoi = ch
      dt_ch.de_thi = dt
      dt_ch.save
      return_obj :status => :ok
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end
end
