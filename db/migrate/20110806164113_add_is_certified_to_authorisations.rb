class AddIsCertifiedToAuthorisations < ActiveRecord::Migration
  def change
    add_column :authorisations, :is_certified, :boolean
  end
end
