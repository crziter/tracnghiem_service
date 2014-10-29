class CauHoi < ActiveRecord::Base
  has_many :lst_de_thi_cau_hoi, :class_name => 'DeThiCauHoi'
  # has_many :lst_de_thi, :through => :de_thi_cau_hois
end
