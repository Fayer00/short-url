module Api
  module V1
    class ClickResource < JSONAPI::Resource
      attributes :url_id
      has_one :url
    end
  end
end