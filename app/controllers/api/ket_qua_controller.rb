class Api::KetQuaController < ApplicationController
  def index
    @qks = KetQua.all
    return_obj @kqs
  end
end
