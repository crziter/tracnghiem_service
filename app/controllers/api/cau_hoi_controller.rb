class Api::CauHoiController < ApplicationController
  def index
    @chs = CauHoi.all
    return_obj @chs
  end

  def create
    begin
      ch_json = JSON.parse(request.raw_post)
      @ch = CauHoi.new

      @ch.noi_dung = ch_json['noi_dung']
      @ch.a = ch_json['a']
      @ch.b = ch_json['b']
      @ch.c = ch_json['c']
      @ch.d = ch_json['d']
      @ch.save

      if @ch.noi_dung == nil || @ch.a == nil || @ch.b == nil || @ch.c == nil || @ch.d == nil
        raise 'CauHoi invalid'
      end
      
      return_obj :status => :ok, :id => @ch.id
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end

  def list_by_de_thi
    begin
      dt_id = params[:id]
      dt = DeThi.where(id: dt_id).first

      chs = []
      dt.lst_de_thi_cau_hoi.each do |dt_ch|
        chs << dt_ch.cau_hoi
      end

      return_obj chs
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end
end
