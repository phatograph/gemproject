class AddEndedAtToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :ended_at, :datetime
  end
end
