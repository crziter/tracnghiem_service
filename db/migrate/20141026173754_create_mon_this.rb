class CreateMonThis < ActiveRecord::Migration
  def change
    create_table :mon_this do |t|
      t.string :ten

      t.timestamps
    end
  end
end
