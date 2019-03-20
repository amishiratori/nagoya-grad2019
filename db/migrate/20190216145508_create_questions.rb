class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :user
      t.string :author
      t.string :quiz
      t.string :choice1
      t.string :choice2
      t.string :choice3
      t.integer :answer
      t.boolean :clear, default: false
    end
  end
end
