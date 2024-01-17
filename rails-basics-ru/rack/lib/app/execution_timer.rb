# frozen_string_literal: true

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    start = Time.now

    status, headers, body = @app.call(env)

    finish = Time.now

    time = (finish - start) * 1000

    [status, headers, [*body, "\n", time]]
    # END
  end
end
