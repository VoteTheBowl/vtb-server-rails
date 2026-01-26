class CreateBallots < ActiveRecord::Migration[8.1]
  def change
    create_table :ballots do |t|
      t.string :token
      t.string :voter_name
      t.datetime :created
      t.string :vote
      t.datetime :submitted

      t.timestamps
    end
  end
end
