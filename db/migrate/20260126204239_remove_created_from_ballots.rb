class RemoveCreatedFromBallots < ActiveRecord::Migration[8.1]
  def change
    remove_column :ballots, :created, :datetime
  end
end
