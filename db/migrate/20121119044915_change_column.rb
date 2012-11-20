class ChangeColumn < ActiveRecord::Migration
  def up
  	change_column :cats, :shared_id, :string
  end

  def down
  end
end
