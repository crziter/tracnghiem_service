class CreateThiSinhs < ActiveRecord::Migration
  def change
    create_table :thi_sinhs do |t|
      t.string :ten_dang_nhap
      t.string :mat_khau
      t.string :ten_that
      t.date :ngay_sinh
      t.string :email

      t.timestamps
    end
  end
end
