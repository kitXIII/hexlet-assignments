# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app)
    @app = app
  end
  # BEGIN
  def call(env)
    locale = extract_locale_from_accept_language_header(env)
    I18n.locale = if locale && I18n.available_locales.include?(locale.to_sym)
                    locale
                  else
                    I18n.default_locale
                  end

     @app.call(env)
  end

  private

  def extract_locale_from_accept_language_header(env)
    if env.has_key? 'HTTP_ACCEPT_LANGUAGE'
        env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
  end
  # END
end
