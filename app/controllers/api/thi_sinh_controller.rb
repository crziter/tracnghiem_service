class Api::ThiSinhController < ApplicationController
  def dang_nhap
    ts_json = JSON.parse(request.raw_post)
    @ts = ThiSinh.where(ten_dang_nhap: ts_json['ten_dang_nhap'], mat_khau: ts_json['mat_khau']).first

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

  def index
    @tss = ThiSinh.all
    return_obj @tss
  end

  def create
    @rs = nil

    begin
      ts_json = JSON.parse(request.raw_post);
      @ts = ThiSinh.new
      @ts.ten_dang_nhap = ts_json['ten_dang_nhap']
      @ts.mat_khau      = ts_json['mat_khau']
      @ts.ten_that      = ts_json['ten_that']
      @ts.email         = ts_json['email']

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
end
