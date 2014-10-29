class ThiSinh < ActiveRecord::Base
  has_many :lst_thi, :class_name => 'Thi'
end
