class AddContentStatusToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :status, :integer, :default => 0
    add_column :tasks, :content, :text
  end
end
