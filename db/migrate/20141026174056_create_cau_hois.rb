class CreateCauHois < ActiveRecord::Migration
  def change
    create_table :cau_hois do |t|
      t.text :noi_dung
      t.text :a
      t.text :b
      t.text :c
      t.text :d

      t.timestamps
    end
  end
end
