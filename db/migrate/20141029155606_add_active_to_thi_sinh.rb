class AddActiveToThiSinh < ActiveRecord::Migration
  def change
    add_column :thi_sinhs, :active, :boolean
  end
end
