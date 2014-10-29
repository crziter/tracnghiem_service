class Api::KetQuaController < ApplicationController
  def index
    @kqs = KetQua.all
    return_obj @kqs
  end
end
