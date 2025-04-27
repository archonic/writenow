class HocuspocusRecord < ActiveRecord::Base
  self.abstract_class = true

  connects_to database: { reading: :hocuspocus, writing: :hocuspocus }
end
