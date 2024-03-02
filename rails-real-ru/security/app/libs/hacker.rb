# frozen_string_literal: true

require 'open-uri'

class Hacker
  class << self
    def hack(email, password)
      # BEGIN
      hostname = 'https://rails-collective-blog-ru.hexlet.app'
      get_path = '/users/sign_up'
      post_path = '/users'

      uri = URI(hostname)

      uri.path = get_path

      res = uri.open()
      html = Nokogiri::HTML(res.read)

      cookie = res.meta['set-cookie'].split(';')[0]
      # csrf_token = html.at('meta[name="csrf-token"]')['content']

      authenticity_token = html.at('input[name="authenticity_token"]')['value']

      params = { 'user[email]' => email, 'user[password]' => password, 'user[password_confirmation]' => password, authenticity_token: }

      uri.path = post_path
      req = Net::HTTP::Post.new(uri)
      req.body = URI.encode_www_form(params)
      req['Cookie'] = cookie
      # req['X-Csrf-Token'] = csrf_token

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      http.request req
    end
    # END
  end
end
