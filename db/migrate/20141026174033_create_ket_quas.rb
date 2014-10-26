class CreateKetQuas < ActiveRecord::Migration
  def change
    create_table :ket_quas do |t|
      t.integer :cau_hoi_id
      t.integer :thi_id
      t.integer :tra_loi

      t.timestamps
    end
  end
end
