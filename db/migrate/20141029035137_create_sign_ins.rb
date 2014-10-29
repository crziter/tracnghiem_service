class CreateSignIns < ActiveRecord::Migration
  def change
    create_table :sign_ins do |t|
      t.string :token
      t.string :ten_dang_nhap
      t.datetime :thoi_gian

      t.timestamps
    end
  end
end
