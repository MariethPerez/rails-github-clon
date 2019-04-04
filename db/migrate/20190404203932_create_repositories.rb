class CreateRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :repositories do |t|
      t.string :name
      t.text :description
      t.string :access
      t.string :license
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
