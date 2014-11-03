class Api::CauHoiController < ApplicationController
  def index
    @chs = CauHoi.all
    return_obj @chs
  end

  # Trả về id mới xóa nếu thành công
  def destroy
    begin
      ch_id = params[:id]

      ch = CauHoi.where(id: ch_id).first
      if ch == nil
        raise 'CauHoi not found'
      end

      ch.destroy
      return_obj :status => :ok, :id => ch.id
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end

  # Trả về id câu hỏi mới tạo
  def create
    begin
      ch_json = JSON.parse(request.raw_post)

      # Check dap_an validated
      da = ch_json['dap_an'].to_i

      if da < 1 || da > 4
        raise 'dap_an invalid'
      end

      @ch = CauHoi.new

      @ch.noi_dung = ch_json['noi_dung']
      @ch.a = ch_json['a']
      @ch.b = ch_json['b']
      @ch.c = ch_json['c']
      @ch.d = ch_json['d']

      if @ch.noi_dung == nil || @ch.a == nil || @ch.b == nil || @ch.c == nil || @ch.d == nil
        raise 'CauHoi invalid'
      end

      @ch.save

      # Save dap_an
      da_tmp = DapAn.where(cau_hoi_id: @ch.id).first
      dpa = DapAn.new
      if da_tmp != nil
        dpa = da_tmp
      end

      dpa.cau_hoi = @ch
      dpa.dap_an = da
      dpa.save

      return_obj :status => :ok, :id => @ch.id
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end

  def update
    begin
      ch_id = params[:id]
      @ch = CauHoi.where(id: ch_id).first
      if @ch == nil
        raise 'CauHoi not found'
      end

      ch_json = JSON.parse(request.raw_post)

      # Check dap_an validated
      da = ch_json['dap_an']

      if da != nil
        if da.to_i < 1 || da.to_i > 4
          raise 'dap_an invalid'
        end
      end

      # Check update fields
      if ch_json['noi_dung'] != nil
        @ch.noi_dung = ch_json['noi_dung']
      end

      if ch_json['a'] != nil
        @ch.a = ch_json['a']
      end

      if ch_json['b'] != nil
        @ch.b = ch_json['b']
      end

      if ch_json['c'] != nil
        @ch.c = ch_json['c']
      end

      if ch_json['d'] != nil
        @ch.d = ch_json['d']
      end

      @ch.save

      if da != nil
        da_tmp = DapAn.where(cau_hoi_id: obj['cau_hoi_id']).first
        dpa = nil
        if da_tmp == nil
          dpa = DapAn.new
        else
          dpa
        end

        dpa.cau_hoi = @ch
        dpa.dap_an = da.to_i
        dpa.save
      end

      return_obj :status => :ok, :id => @ch.id
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end

  # Trả về các câu hỏi theo mã đề thi
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

  def list_with_da
    begin
      dt_id = params[:id]
      dt = DeThi.where(id: dt_id).first
      chs = []

      dt.lst_de_thi_cau_hoi.each do |dt_ch|
        ch = {}
        ch[:id] = dt_ch.cau_hoi.id
        ch[:noi_dung] = dt_ch.cau_hoi.noi_dung
        ch[:a] = dt_ch.cau_hoi.a
        ch[:b] = dt_ch.cau_hoi.b
        ch[:c] = dt_ch.cau_hoi.c
        ch[:d] = dt_ch.cau_hoi.d

        da = DapAn.where(cau_hoi_id: dt_ch.cau_hoi.id).first
        ch[:da] = da.dap_an
        ch[:da_id] = da.id

        chs << ch
      end

        return_obj chs
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end
end
