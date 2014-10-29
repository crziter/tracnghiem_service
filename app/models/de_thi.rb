class DeThi < ActiveRecord::Base
  belongs_to :mon_thi
  has_many :lst_de_thi_cau_hoi, :class_name => 'DeThiCauHoi'
  # has_many :lst_cau_hoi, :through => :de_thi_cau_hois
end
