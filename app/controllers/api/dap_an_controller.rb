class Api::DapAnController < ApplicationController
  def create
    begin
      obj = JSON.parse(request.raw_post)
      da = obj['dap_an'].to_i

      if da < 1 || da > 4
        raise 'dap_an invalid'
      end

      ch = CauHoi.where(id: obj['cau_hoi_id']).first
      if ch == nil
        raise 'CauHoi not found'
      end

      dpa = DapAn.new
      dpa.cau_hoi = ch
      dpa.dap_an = da
      dpa.save

      ch.dap_an = dpa
      ch.save

      return_obj :status => :ok, :id => dpa.id
    rescue Exception => e
      return_obj :status => :fail, :reason => e.message
    end
  end
end
