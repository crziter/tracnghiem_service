class MonThi < ActiveRecord::Base
  has_many :lst_de_thi, :class_name => 'DeThi'
end
