class ChangeTitleToBeTypeTextInArticles < ActiveRecord::Migration[6.0]
  def change
    change_column :articles, :title, :text
  end
end
