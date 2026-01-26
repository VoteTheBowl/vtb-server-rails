class AddUniqueBallotIndexToBallots < ActiveRecord::Migration[8.1]
  def change
    add_index :ballots, [ :voter_name, :event_id ], unique: true
  end
end
