class CreateThis < ActiveRecord::Migration
  def change
    create_table :this do |t|
      t.integer :thi_sinh_id
      t.integer :de_thi_id
      t.datetime :thoi_gian_bat_dau
      t.datetime :thoi_gian_ket_thuc

      t.timestamps
    end
  end
end
