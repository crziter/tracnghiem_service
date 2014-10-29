class AddCurrentThiToSignin < ActiveRecord::Migration
  def change
    add_column :sign_ins, :thi_id, :integer
  end
end
