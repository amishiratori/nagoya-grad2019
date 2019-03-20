class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :mentor_name
      t.integer :month
      t.integer :date
      t.integer :score, default: 0
      t.boolean :clear, default: false
    end
  end
end
