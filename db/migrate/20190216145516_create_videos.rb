class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.references :user
      t.string :author
      t.string :url
      t.boolean :played, default: false
    end
  end
end
