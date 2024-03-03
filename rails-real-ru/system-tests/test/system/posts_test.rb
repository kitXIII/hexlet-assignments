# frozen_string_literal: true

require 'application_system_test_case'

# BEGIN
class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)

    @attributes = {
      title: Faker::Movies::Hobbit.character,
      body: Faker::Movies::Hobbit.quote
    }
  end

  test 'visiting the index' do
    visit posts_url
    assert_selector 'h1', text: 'Posts'
  end

  test 'showing a Post' do
    visit posts_url

    find('tr', text: @post.title).click_link('Show')

    assert_selector 'h1', text: @post.title
    assert_text @post.body

    click_on 'Back'
  end

  test 'creating a Post' do
    visit posts_url
    click_on 'New Post'

    fill_in "Title", with: @attributes[:title]
    fill_in "Body", with: @attributes[:body]

    click_on 'Create Post'

    assert_text 'Post was successfully created'
    assert_text @attributes[:title]
    assert_text @attributes[:body]

    click_on 'Back'
  end

  test 'updating a Post' do
    visit posts_url
    click_on 'Edit', match: :first

    fill_in "Title", with: @attributes[:title]
    fill_in "Body", with: @attributes[:body]

    click_on 'Update Post'

    assert_text 'Post was successfully updated'
    assert_text @attributes[:title]
    assert_text @attributes[:body]

    click_on 'Back'
  end

  test 'destroying a Post' do
    visit posts_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Post was successfully destroyed'
  end
end
# END
