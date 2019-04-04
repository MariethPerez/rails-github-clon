class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.date :birthday
      t.string :email
      t.text :bio
      t.string :company
      t.string :location
      t.string :website

      t.timestamps
    end
  end
end
