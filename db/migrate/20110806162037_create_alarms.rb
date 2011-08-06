class CreateAlarms < ActiveRecord::Migration
  def change
    create_table :alarms do |t|
      t.text :location
      t.string :phone_number

      t.timestamps
    end
  end
end
