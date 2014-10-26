class CreateDapAns < ActiveRecord::Migration
  def change
    create_table :dap_ans do |t|
      t.integer :cau_hoi_id
      t.integer :dap_an

      t.timestamps
    end
  end
end
