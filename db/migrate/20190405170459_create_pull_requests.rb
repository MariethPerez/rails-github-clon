class CreatePullRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :pull_requests do |t|
      t.string :title
      t.string :status
      t.text :description
      t.references :branch_in, :references => "branch"
      t.references :branch_out, :references => "branch"

      t.timestamps
    end
  end
end
