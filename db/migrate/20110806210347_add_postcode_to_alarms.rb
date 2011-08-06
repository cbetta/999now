class AddPostcodeToAlarms < ActiveRecord::Migration
  def change
    add_column :alarms, :postcode, :string
  end
end
