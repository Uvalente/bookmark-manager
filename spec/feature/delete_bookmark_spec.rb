# frozen_string_literal: true

feature 'Deleting bookmark' do
  scenario 'User can delete a bookmark' do
    Bookmark.add_bookmark(url: 'http://www.twitter.com', title: 'Twitter')
    Bookmark.add_bookmark(url: 'http://www.imatest.com', title: 'Test')
    Bookmark.add_bookmark(url: 'http://www.google.com', title: 'Google')
    visit '/bookmarks'
    click_on "Delete Test"
    expect(page).not_to have_link('Test', href: 'http://www.imatest.com')
    expect(page).to have_link('Twitter', href: 'http://www.twitter.com')
    expect(page).to have_link('Google', href: 'http://www.google.com')
  end
end
