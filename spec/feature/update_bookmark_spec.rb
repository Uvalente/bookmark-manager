# frozen_string_literal: true

feature 'add bookmark' do
  scenario 'user type in a url to save' do
    visit '/bookmarks'
    fill_in 'url', with: 'http://www.mock.com'
    fill_in 'title', with: 'Mock'
    click_button 'Add Bookmark'
    within(:css, "form.update") do
      fill_in 'url', with: 'http://www.newurl.com'
      fill_in 'title', with: 'New Mock'
      click_button 'Update Mock'
    end
    expect(page).to have_link('New Mock', href: 'http://www.newurl.com')
  end
end
