# frozen_string_literal: true

require 'bookmark'

describe Bookmark do
  describe '#all' do
    it 'shows all bookmarks' do
      Bookmark.instance
      Bookmark.add_bookmark(url: 'http://www.makersacademy.com', title: 'Makers')
      Bookmark.add_bookmark(url: 'http://www.twitter.com', title: 'Twitter')
      Bookmark.add_bookmark(url: 'http://www.google.com', title: 'Google')

      expect(Bookmark.all).to include(an_instance_of(Bookmark))
      expect(Bookmark.all[1].url).to eq 'http://www.twitter.com'
      expect(Bookmark.all.last.title).to eq 'Google'
    end
  end

  describe '#create' do
    it 'respond to create' do
      expect(Bookmark).to receive(:create)
      Bookmark.create
    end
  end
end
