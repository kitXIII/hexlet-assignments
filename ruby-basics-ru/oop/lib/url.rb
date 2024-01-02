# frozen_string_literal: true

# BEGIN
require 'uri'
require 'forwardable'

class Url
  include Comparable
  extend Forwardable
  def_delegators :@url, :scheme, :host, :port

  def initialize(url)
    @url = URI(url)
    @params = get_normalized_params(@url.query)
    @url.query = @params.map { |key, val| "#{key}=#{val}" }
                        .join('&')
  end

  def query_params
    @params
  end

  def query_param(key, default = nil)
    @params.fetch(key, default)
  end

  def <=>(other)
    to_s <=> other.to_s
  end

  def to_s
    @url.to_s
  end

  private

  def get_normalized_params(query)
    params = (query || '').split('&')
                          .to_h { |pair| pair.split('=') }

    params.keys
          .sort
          .each_with_object({}) { |k, acc| acc[k.to_sym] = params[k] }
  end
end
# END
