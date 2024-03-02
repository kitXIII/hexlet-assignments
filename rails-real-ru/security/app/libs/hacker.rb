# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'net/https'

class Hacker
  class << self
    def hack(email, password)
      # BEGIN
      hostname = 'https://rails-collective-blog-ru.hexlet.app'
      get_path = '/users/sign_up'
      post_path = '/users'

      uri = URI(hostname)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Get.new URI.join(hostname, get_path)

      res = http.request req

      cookie = res.response['set-cookie'].split('; ')[0]
      # csrf_token = html.at('meta[name="csrf-token"]')['content']

      params = {
        'user[email]': email,
        'user[password]': password,
        'user[password_confirmation]': password,
        authenticity_token: auth_token(res.body)
      }

      req = Net::HTTP::Post.new URI.join(hostname, post_path)
      req.body = URI.encode_www_form(params)
      req['Cookie'] = cookie
      # req['X-Csrf-Token'] = csrf_token

      res = http.request req

      res.code == '302'
    end

    private

    def auth_token(body)
      html = Nokogiri::HTML(body)

      html.at('input[@name="authenticity_token"]')['value']
    end
    # END
  end
end
