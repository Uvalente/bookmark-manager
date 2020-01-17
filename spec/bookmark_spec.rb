# frozen_string_literal: true

require 'bookmark'

describe Bookmark do
  describe '.all' do
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

  describe '.create' do
    it 'respond to create' do
      expect(Bookmark).to receive(:create)
      Bookmark.create
    end
  end

  describe '.find' do
    it 'return a bookmark' do
      Bookmark.add_bookmark(url: 'http://www.makersacademy.com', title: 'Makers')
      bookmark = Bookmark.add_bookmark(url: 'http://www.twitter.com', title: 'Twitter')
      Bookmark.add_bookmark(url: 'http://www.google.com', title: 'Google')

      expect(Bookmark.find(bookmark.id).id).to eq bookmark.id
    end
  end

  describe '.update' do
    it 'updates a bookmark' do
      bookmark = Bookmark.add_bookmark(url: 'http://www.makersacademy.com', title: 'Makers')
      Bookmark.update(id: bookmark.id, url: 'http://www.newurl.com', title: 'New Title')

      expect(Bookmark.find(bookmark.id).title).to eq 'New Title'
      expect(Bookmark.find(bookmark.id).url).to eq 'http://www.newurl.com'
    end
  end

  describe '.delete' do
    before(:each) do
      Bookmark.instance
      Bookmark.add_bookmark(url: 'http://www.makersacademy.com', title: 'Makers')
      Bookmark.add_bookmark(url: 'http://www.twitter.com', title: 'Twitter')
      Bookmark.add_bookmark(url: 'http://www.google.com', title: 'Google')
    end

    it 'can delete one bookmark' do
      bookmark = Bookmark.all[1]
      Bookmark.delete(bookmark.id)
      expect(Bookmark.all.length).to eq 2
      expect(Bookmark.all.first.title).to eq 'Makers'
      expect(Bookmark.all.last.title).to eq 'Google'
    end

    it 'delete the right bookmark' do
      bookmark = Bookmark.all[0]
      Bookmark.delete(bookmark.id)
      expect(Bookmark.all.length).to eq 2
      expect(Bookmark.all.first.title).to eq 'Twitter'
      expect(Bookmark.all.last.title).to eq 'Google'
    end
  end
end
