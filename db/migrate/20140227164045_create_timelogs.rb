class CreateTimelogs < ActiveRecord::Migration
  def change
    create_table :timelogs do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.references :assignment, index: true

      t.timestamps
    end
  end
end
