class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :votable, polymorphic: true, index: true
      t.integer :up, default: 0
      t.integer :down, default: 0
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
