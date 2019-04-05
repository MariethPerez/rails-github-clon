class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.string :title
      t.text :description
      t.string :label
      t.references :user_create, :references => "user"
      t.references :user_assign, :references => "user"

      t.timestamps
    end
  end
end
