class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :project_name
      t.string :project_description
      t.string :identifier
      t.boolean :public
      t.boolean :issue_tracking
      t.boolean :project_news
      t.boolean :wiki
      t.string :assigned_to
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
