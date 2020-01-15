# frozen_string_literal: true

feature 'Bookmark list' do
  scenario 'shows bookmark list' do
    Bookmark.add_bookmark(url: 'http://www.twitter.com', title: 'Twitter')
    Bookmark.add_bookmark(url: 'http://www.google.com', title: 'Google')

    visit '/bookmarks'
    expect(page).to have_link('Twitter', href: 'http://www.twitter.com')
    expect(page).to have_link('Google', href: 'http://www.google.com')
  end
end
