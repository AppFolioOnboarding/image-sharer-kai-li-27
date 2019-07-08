class CreateFeedbacksTable < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.string :name, null: false
      t.string :comments, null: false
      t.timestamps
    end
  end
end
