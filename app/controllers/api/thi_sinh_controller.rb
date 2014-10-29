class Api::ThiSinhController < ApplicationController
  def dang_nhap
    ts_json = JSON.parse(request.raw_post)
    @ts = ThiSinh.where(ten_dang_nhap: ts_json['ten_dang_nhap'], mat_khau: ts_json['mat_khau'], active: true).first

    if @ts == nil
      return_obj :status => :fail, :reason => 'invalid information'
    else
      begin
        token = SecureRandom.uuid
        si = SignIn.new
        si.token = token
        si.ten_dang_nhap = @ts.ten_dang_nhap
        si.thoi_gian = Time.now
        si.save

        return_obj :status => :ok, :token => token
      rescue Exception => e
        return_obj :status => :fail, :reason => e.message
      end
    end
  end

  def dang_xuat
    begin
      ts_json = JSON.parse(request.raw_post)
      sess = SignIn.where(token: ts_json['token']).first
      if sess == nil
        raise 'Token not found'
      end

      sess.destroy

      return_obj :status => :ok
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end

  def index
    @tss = ThiSinh.all
    return_obj @tss
  end

  def create
    @rs = nil

    begin
      ts_json = JSON.parse(request.raw_post);

      @ts = ThiSinh.where(ten_dang_nhap: ts_json['ten_dang_nhap']).first
      if @ts != nil
        raise 'Can\' use ten_dang_nhap: ' + ts_json['ten_dang_nhap']
      end

      @ts = ThiSinh.new
      @ts.ten_dang_nhap = ts_json['ten_dang_nhap']
      @ts.mat_khau      = ts_json['mat_khau']
      @ts.ten_that      = ts_json['ten_that']
      @ts.email         = ts_json['email']
      @ts.active        = ts_json['active']

      if @ts.ten_dang_nhap == nil || @ts.mat_khau == nil || @ts.ten_that = nil || @ts.email == nil
        raise 'invalid information'
      end

      @ts.save
      @rs = { :status => :ok, :id => @ts.id }
    rescue Exception => e
      @rs = { :status => :fail, :reason => e.message }
    end

    return_obj @rs
  end

  def destroy
    begin
      ts_id = params[:id]
      ts = ThiSinh.where(id: ts_id).first
      if ts == nil
        raise 'ThiSinh not found'
      end

      ts.active = false
      ts.save

    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end

  def update
    begin
      ts_id = params[:id]
      ts_json = JSON.parse(request.raw_post)
      ts = ThiSinh.where(id: ts_id).first

      if ts == nil
        raise 'ThiSinh not found'
      end

      tdn = ts_json['ten_dang_nhap']
      mk = ts_json['mat_khau']
      tt = ts_json['ten_that']
      em = ts_json['email']
      at = ts_json['active']

      if tdn != nil
        ts.ten_dang_nhap = tdn
      end

      if mk != nil
        ts.mat_khau = mk
      end

      if tt != nil
        ts.ten_that = tt
      end

      if em != nil
        ts.email = em
      end

      if at != nil
        ts.active = at
      end

      ts.save

      return_obj :status => :ok, :id => ts.id

    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end
end
