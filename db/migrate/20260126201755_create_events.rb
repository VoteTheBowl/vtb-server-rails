class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :share_token
      t.string :hose_token
      t.string :choices
      t.datetime :created
      t.boolean :show_results
      t.datetime :closed
      t.string :electoral_system

      t.timestamps
    end
  end
end
