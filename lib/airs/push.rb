require 'net/https'

module Airs
  class Push
    URL   = 'https://api.pushover.net/1/messages.json'
    TOKEN = '2mFVOz9QhQKdUipmVnARrA38z6lfQv'

    def initialize(message)
      @message = message
    end

    def send!
      http_post(URI.parse(URL),
                user: user,
                token: TOKEN,
                message: message)
    rescue
      raise "Error accessing pushover.net"
    end

    private

    attr_reader :message

    def http_post(uri, fields)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER

      req = Net::HTTP::Post.new(uri.path)
      req.set_form_data(fields)

      http.start { |sess| sess.request(req) }
    end

    def user
      ENV.fetch('PUSHOVER_USER') { raise "PUSHOVER_USER not set" }
    end

  end
end
