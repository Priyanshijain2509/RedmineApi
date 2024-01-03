class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :comment_body
      t.string :comment_added_by
      t.integer :project_id
      t.integer :user_id
      t.integer :news_id
      t.timestamps
    end
    add_foreign_key :comments, :projects
    add_foreign_key :comments, :users
    add_foreign_key :comments, :news
  end
end
