module ShortUrl
  require 'uri'
  class Creator

    attr_accessor :url

    def initialize(url: )
      @url = url
    end

    def new_shorty
      if valid_url?(url)
        new_uri = Url.new(original_url: url)
        new_uri.short_url = generate_short_url
        new_uri.original_url = sanitize

        if new_uri.save
          { status: "SUCCESS", result: new_uri }.compact
        end
      else
        { status: "ERROR", errors: "Invalid URL: #{url}" }.compact
      end
    end


    private

    def valid_url?(url)
      uri = URI.parse(url)
      uri.is_a?(URI::HTTP) && !uri.host.nil?
    rescue
      { status: 'ERROR', errors: URI::InvalidURIError }
    end

    def generate_short_url
      [*'A'..'Z'].sample(5).join
    end

    def sanitize
      url.strip!
      sanitize_url = url.downcase.gsub(%r{(https?://)|(www\.)}, '')
      "http://#{sanitize_url}"
    end
  end
end