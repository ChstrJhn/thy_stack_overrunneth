class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question
      t.references :user
      t.string :text
      t.boolean :best_answer, default:false

      t.timestamps null: false
    end
  end
end
