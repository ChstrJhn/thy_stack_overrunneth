class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :user
      t.string :title
      t.string :content
      t.integer :views, default: 0
      t.integer :rank, default:0 #ups minus downs
      t.boolean :trending, default: false

      t.timestamps null: false
    end
  end
end
