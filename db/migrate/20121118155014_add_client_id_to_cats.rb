class AddClientIdToCats < ActiveRecord::Migration
  def change
    add_column :cats, :client_id, :integer
  end
end
