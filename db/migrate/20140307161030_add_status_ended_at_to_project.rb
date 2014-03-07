class AddStatusEndedAtToProject < ActiveRecord::Migration
  def change
    add_column :projects, :status, :integer, :default => 0
    add_column :projects, :ended_at, :datetime
  end
end
