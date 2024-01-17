# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    status, headers, body = @app.call(env)

    dig = Digest::SHA2.hexdigest body[0]

    enriched_body = [body[0], "\n", dig].join

    [status, headers, [enriched_body]]
    # END
  end
end
