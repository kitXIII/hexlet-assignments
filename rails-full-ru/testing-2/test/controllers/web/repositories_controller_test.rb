# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  # BEGIN
  test 'should create repo' do
    response = load_fixture('files/response.json')
    link = '/some/path'

    uri_template = Addressable::Template.new "https://api.github.com/repos#{link}"
    stub_request(:get, uri_template).
      to_return(body: response, headers: { content_type: 'application/json' })

    post repositories_url params: { repository: { link: } }

    repo = Repository.find_by(link:)

    assert repo.present?
    assert_redirected_to repositories_url
  end
  # END
end
