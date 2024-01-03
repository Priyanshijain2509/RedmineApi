class CreateNews < ActiveRecord::Migration[7.0]
  def change
    create_table :news do |t|
      t.string :news_title
      t.string :news_content
      t.string :news_added_by
      t.integer :project_id

      t.timestamps
    end
    add_foreign_key :news, :projects
  end
end
