# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    prev_response = @app.call(env)
    status, headers, body = prev_response

    return prev_response unless status == 200

    dig = Digest::SHA2.hexdigest body[0]
    enriched_body = body.push('<br>', dig)

    [status, headers, [enriched_body.join]]
    # END
  end
end
