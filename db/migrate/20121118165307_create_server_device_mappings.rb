class CreateServerDeviceMappings < ActiveRecord::Migration
  def change
    create_table :server_device_mappings do |t|
      t.string :name
      t.string :serverid
      t.string :uuid

      t.timestamps
    end
  end
end
