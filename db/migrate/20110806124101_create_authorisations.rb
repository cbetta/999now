class CreateAuthorisations < ActiveRecord::Migration
  def change
    create_table :authorisations do |t|
      t.string :phone_number
      t.boolean :confirmed

      t.timestamps
    end
  end
end
