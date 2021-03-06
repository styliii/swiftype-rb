module Swiftype
  class Engine < BaseModel
    def self.find(id)
      new Swiftype::Client.new.get("engines/#{id}.json")
    end

    def build_document_type(params={})
      DocumentType.new({
        :engine_id => id
      }.merge(params))
    end

    def create_document_type(params={})
      doc = build_document_type(params)
      doc.create!
      doc
    end

    def destroy_document_type(document_type_name)
      !!delete("engines/#{slug}/document_types/#{document_type_name}")
    rescue NonExistentRecord
      false
    end

    def document_type(id)
      DocumentType.new get("engines/#{slug}/document_types/#{id}.json")
    end

    def document_types
      get("engines/#{slug}/document_types.json").map { |dt| DocumentType.new(dt) }
    end
  end
end
