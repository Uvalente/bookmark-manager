# frozen_string_literal: true

require 'pg'

class Bookmark
  attr_reader :id, :url, :title

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end

  def self.instance
    @database ||= create
  end

  def self.create
    dbname = ENV['ENVIRONMENT'] == 'test' ? 'bookmark_manager_test' : 'bookmark_manager'
    @database = PG.connect(dbname: dbname)
  end

  def self.all
    @database.exec('SELECT * FROM bookmarks').map do |bookmark|
      Bookmark.new(id: bookmark['id'], url: bookmark['url'], title: bookmark['title'])
    end
  end

  def self.add_bookmark(url:, title:)
    bookmark = @database.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, url, title;")
    Bookmark.new(id: bookmark[0]['id'], url: bookmark[0]['url'], title: bookmark[0]['title'])
  end

  def self.delete(id)
    @database.exec("DELETE FROM bookmarks WHERE id='#{id}';")
  end

  def self.find(id)
    bookmark = @database.exec("SELECT * FROM bookmarks WHERE id='#{id}';")
    Bookmark.new(id: bookmark[0]['id'], url: bookmark[0]['url'], title: bookmark[0]['title'])
  end

  def self.update(id:, url:, title:)
    bookmark = find(id)
    url = bookmark.url if url.empty?
    title = bookmark.title if title.empty?
    @database.exec("UPDATE bookmarks SET url='#{url}', title='#{title}' WHERE id='#{id}'")
  end
end
