class AddRequesterToProject < ActiveRecord::Migration
  def change
    add_column :projects, :requester_name, :string
    add_column :projects, :requester_department, :string
  end
end
