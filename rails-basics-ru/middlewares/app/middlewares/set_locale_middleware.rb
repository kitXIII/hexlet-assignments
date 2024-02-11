# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app)
    @app = app
  end
  # BEGIN
  def call(env)
    I18n.locale = extract_locale_from_accept_language_header(env) || I18n.default_locale

    @app.call(env)
  end

  private

  def extract_locale_from_accept_language_header(env)
    locale = env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first

    locale && I18n.available_locales.include?(locale.to_sym) ? locale : nil
  end
  # END
end
