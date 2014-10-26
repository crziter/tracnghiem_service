class CreateDeThiCauHois < ActiveRecord::Migration
  def change
    create_table :de_thi_cau_hois do |t|
      t.integer :cau_hoi_id
      t.integer :de_thi_id

      t.timestamps
    end
  end
end
