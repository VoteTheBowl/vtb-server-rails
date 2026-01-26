class FixHostTokenTypeOnEvents < ActiveRecord::Migration[8.1]
  def change
    rename_column :events, :hose_token, :host_token
  end
end
