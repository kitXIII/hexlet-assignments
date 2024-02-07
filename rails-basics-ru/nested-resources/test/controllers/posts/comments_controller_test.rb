# frozen_string_literal: true

require 'test_helper'

class PostsCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @comment = @post.post_comments.first

    @attrs = {
      body: Faker::ChuckNorris.fact
    }
  end

  test 'should get edit comment' do
    get edit_comment_url(@comment)
    assert_response :success
  end

  test 'should create comment' do
    post post_comments_url(@post), params: { post_comment: @attrs }

    comment = PostComment.find_by @attrs

    assert { comment }
    assert_redirected_to post_url(@post)
  end

  test 'should update comment' do
    patch comment_url(@comment), params: { post_comment: @attrs }

    comment = PostComment.find_by @attrs

    assert { comment }
    assert_redirected_to post_url(@post)
  end

  test 'should destroy comment' do
    delete comment_url(@comment)

    assert { !PostComment.exists?(@comment.id) }

    assert_redirected_to post_url(@post)
  end
end
