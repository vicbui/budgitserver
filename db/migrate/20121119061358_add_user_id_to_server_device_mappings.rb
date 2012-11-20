class AddUserIdToServerDeviceMappings < ActiveRecord::Migration
  def change
  	rename_table :server_device_mappings, :devices
    add_column :devices, :user_id, :integer
  end
end
