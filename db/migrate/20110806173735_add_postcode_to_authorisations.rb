class AddPostcodeToAuthorisations < ActiveRecord::Migration
  def change
    add_column :authorisations, :postcode, :string
  end
end
