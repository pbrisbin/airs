require 'net/https'

class Pushover
  API = 'https://api.pushover.net/1/messages.json'

  def initialize(api_token)
    @token = api_token
  end

  def notify(user_key, message)
    uri = URI.parse(API)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data({
      token:   token,
      user:    user_key,
      message: message
    })

    http.start { |sess| sess.request(req) }
  rescue => ex
    $stderr.puts "Error accessing api.pushover.net"
    raise ex
  end

  private

  attr_reader :token

end
