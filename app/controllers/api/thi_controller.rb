class Api::ThiController < ApplicationController
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

      thi = Thi.new
      thi.de_thi = dt
      thi.thi_sinh = usr
      thi.save

      usr.thi_id = thi.id
      usr.save

      return_obj :status => :ok, :id => thi.id
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end
end
