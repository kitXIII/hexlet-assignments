# frozen_string_literal: true

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    start = Time.now.to_f
    status, headers, prev_body = @app.call(env)
    finish = Time.now.to_f

    time = (finish - start) * 1_000_000
    next_body = prev_body.push('</br>', time)

    [status, headers, next_body]
    # END
  end
end
