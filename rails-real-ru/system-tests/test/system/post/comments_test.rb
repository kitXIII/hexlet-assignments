# frozen_string_literal: true

require 'application_system_test_case'

# BEGIN
class PostCommentsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
    @comment = post_comments(:one)
    @comment_body = Faker::Movies::Hobbit.quote
  end

  test 'showing Comments' do
    visit post_url(@post)

    assert_selector 'h3', text: 'Comments'
    assert_text @comment.body
  end

  test 'creating a Comment' do
    visit post_url(@post)

    fill_in "post_comment[body]", with: @comment_body

    click_on 'Create Comment'

    assert_text 'Comment was successfully created'
    assert_text @comment_body
  end

  test 'updating a Comment' do
    visit post_url(@post)

    click_on 'Edit', match: :first

    fill_in "Body", with: @comment_body

    click_on 'Update Comment'

    assert_text 'Comment was successfully updated.'
    assert_text @comment_body
  end

  test 'destroying a Comment' do
    visit post_url(@post)
    page.accept_confirm do
      click_on 'Delete', match: :first
    end

    assert_text 'Comment was successfully destroyed'
  end
end
# END
