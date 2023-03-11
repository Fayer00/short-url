module Api
  module V1
    class UrlResource < JSONAPI::Resource
      include Rails.application.routes.url_helpers
      attributes :created_at, :original_url, :clicks_count

      has_many :clicks

      def custom_links(_options)
        { url: visit_url(@model.short_url) }
      end
    end
  end
end