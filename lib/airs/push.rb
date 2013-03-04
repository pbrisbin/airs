require 'curb'

module Airs
  class Push
    API= 'https://api.pushover.net/1/messages'

    def initialize(message)
      @message = message
    end

    def send!
      Curl::Easy.http_post(API, *post_fields)
    end

    private

    attr_reader :message

    def user
      ENV.fetch('PUSHOVER_USER') { raise "PUSHOVER_USER not set" }
    end

    def token
      ENV.fetch('PUSHOVER_TOKEN') { raise "PUSHOVER_TOKEN not set" }
    end

    def post_fields
      {
        'user'    => user,
        'token'   => token,
        'message' => message
      }.map { |k,v| Curl::PostField.content(k, v) }
    end

  end
end
