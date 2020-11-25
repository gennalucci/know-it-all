class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.text :content_preview
      t.integer :read_mins
      t.string :article_url
      t.references :source, null: false, foreign_key: true

      t.timestamps
    end
  end
end
