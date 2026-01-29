class ModifyChoicesFieldOnEvents < ActiveRecord::Migration[8.1]
  def change
    change_column :events, :choices, :text
  end
end
