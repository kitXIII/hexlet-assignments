# frozen_string_literal: true

# BEGIN
require 'uri'
require 'forwardable'

class Url
  extend Forwardable

  include Comparable
  attr :uri

  attr_reader :query_params

  def initialize(url)
    @uri = URI(url)
    @query_params = if @uri.query
                      @uri.query
                          .split('&')
                          .collect { |param| param.split('=') }
                          .each_with_object({}) { |param, obj| obj[param[0].to_sym] = param[1] }
                    else
                      {}
                    end
  end

  def_delegators :@uri, :scheme, :host, :port

  def <=>(other)
    to_s <=> other.to_s
  end

  def to_s
    params = if query_params.empty?
               nil
             else
               "?#{query_params
                    .to_a
                    .sort { |a, b| a[0] <=> b[0] }
                    .map { |pair| pair.join('=') }
                    .join('&')}"
             end
    port = @uri.port ? ":#{@uri.port}" : nil
    [scheme, '://', host, port, @uri.path, params].compact().join
  end

  def query_param(key, default = nil)
    query_params[key] || default
  end
end
# END
