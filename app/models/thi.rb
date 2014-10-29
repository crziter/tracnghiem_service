class Thi < ActiveRecord::Base
  belongs_to :de_thi
  belongs_to :thi_sinh
  has_many :lst_ket_qua, :class_name => 'KetQua'
end
