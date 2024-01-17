# frozen_string_literal: true

class AdminPolicy
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    request = Rack::Request.new(env)

    if request.path.start_with? '/admin'
      [403, {}, []]
    else
      status, headers, body = @app.call(env)
      [status, headers, body]
    end
    # END
  end
end
