class Hocuspocus < HocuspocusRecord
  self.table_name = "documents"
  self.primary_key = "name"

  # belongs_to :document, class_name: "Document", foreign_key: :name, inverse_of: :token

  # Stuff to translate yjs binary into html?
end
