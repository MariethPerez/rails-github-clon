class CreateBranches < ActiveRecord::Migration[5.2]
  def change
    create_table :branches do |t|
      t.string :name
      t.references :repository, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
