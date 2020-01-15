feature 'add bookmark' do
  scenario 'user type in a url to save' do
    visit '/bookmarks'
    fill_in 'url', with: 'http://www.mock.com'
    fill_in 'title', with: 'Mock'
    click_button 'Add Bookmark'
    expect(page).to have_link('Mock', href: 'http://www.mock.com')
  end
end