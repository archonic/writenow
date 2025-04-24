class CreateDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :documents do |t|
      t.string :name, null: false
      t.string :slug, null: false, unique: true
      t.string :token, null: false, unique: true

      t.index [ "name" ], name: "index_documents_on_name"
      t.index [ "slug" ], name: "index_documents_on_slug"
      t.index [ "token" ], name: "index_documents_on_token"

      t.timestamps
    end
  end
end
