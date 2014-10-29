class Api::ThiController < ApplicationController

  # Trả về id của đối tượng Thi
  # Cần: Mã đề thi, token khi đăng nhập
  def bat_dau_thi
    begin
      json_obj = JSON.parse(request.raw_post)

      dt = DeThi.where(id: json_obj['de_thi_id']).first

      if dt == nil
        raise 'DeThi not found'
      end

      usr = SignIn.where(token: json_obj['token']).first
      if usr == nil
        raise 'User haven\'t signed in yet'
      end

      ts = ThiSinh.where(ten_dang_nhap: usr.ten_dang_nhap).first
      if ts == nil
        raise 'ThiSinh not found'
      end

      thi = Thi.new
      thi.de_thi = dt
      thi.thi_sinh = ts
      thi.save

      usr.thi_id = thi.id
      usr.save

      return_obj :status => :ok, :id => thi.id
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end

  # Cần token và danh sách các câu hỏi + đáp án
  # theo mẫu "cau_hoi_id": "dap_an"
  def thi_xong
    begin
      obj = JSON.parse(request.raw_post)
      usr = SignIn.where(token: obj['token']).first

      if usr == nil
        raise 'User haven\'t signed in yet'
      end

      thi = Thi.where(id: usr.thi_id).first
      if thi == nil
        raise 'User haven\'t begin the test yet'
      end
      
      dethi = thi.de_thi
      if dethi == nil
        raise 'DeThi invalid'
      end

      KetQua.transaction do
        dethi.lst_de_thi_cau_hoi.each do |ch|
          dap_an = 0
          cau_hoi = ch.cau_hoi
          obj.each do |k, v|
            if k != 'token' &&  k.to_i == cau_hoi.id
              dap_an = v.to_i
              break
            end
          end

          kq = KetQua.where(thi_id: thi.id, cau_hoi_id: cau_hoi.id).first
          if kq == nil
            kq = KetQua.new
          end

          kq.cau_hoi = cau_hoi
          kq.thi = thi
          kq.tra_loi = dap_an
          kq.save
        end
      end

      usr.thi_id = nil
      usr.save

      return_obj :status => :ok, :id => thi.id
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end

  # Cần thi_id nhận được khi request đến thi_xong
  def diem
    begin
      diem = 0
      thi_id = params[:id]

      thi = Thi.where(id: thi_id).first
      if thi == nil
        raise 'Thi not found'
      end

      total = thi.lst_ket_qua.count
      da_dung = 0
      thi.lst_ket_qua.each do |kq|
        if kq.cau_hoi.dap_an.dap_an == kq.tra_loi
          da_dung += 1
        end
      end

      diem = da_dung.fdiv(total) * 10.0

      return_obj :status => :ok, :result => diem
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end

  # Cần thi_id nhận được khi request đến thi_xong
  def check_result
    begin
      thi_id = params[:id]
      thi = Thi.where(id: thi_id).first
      if thi == nil
        raise 'Thi not found'
      end

      rs = {}
      thi.lst_ket_qua.each do |kq|
        if kq.tra_loi == kq.cau_hoi.dap_an.dap_an
          rs[kq.cau_hoi.id] = true
        else
          rs[kq.cau_hoi.id] = false
        end
      end

      return_obj :status => :ok, :result => rs
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end
end
