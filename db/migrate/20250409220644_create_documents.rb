class CreateDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :documents do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.text :body

      t.index [ "name" ], name: "index_documents_on_name"

      t.timestamps
    end
  end
end
