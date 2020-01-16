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
    @database.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, url, title;")
  end

  def self.delete(id)
    @database.exec("DELETE FROM bookmarks WHERE id='#{id}';")
  end
end
