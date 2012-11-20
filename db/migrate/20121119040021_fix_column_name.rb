class FixColumnName < ActiveRecord::Migration
  def up
  	    rename_column :cats, :client_id, :shared_id
  end

  def down
  end
end
