class CreateDeThis < ActiveRecord::Migration
  def change
    create_table :de_this do |t|
      t.integer :mon_thi_id
      t.date :ngay_tao

      t.timestamps
    end
  end
end
