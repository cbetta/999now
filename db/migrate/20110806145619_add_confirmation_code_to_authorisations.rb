class AddConfirmationCodeToAuthorisations < ActiveRecord::Migration
  def change
    add_column :authorisations, :confirmation_code, :string
  end
end
