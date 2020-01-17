# frozen_string_literal: true

require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  set :method_override, true

  before do
    @database = Bookmark.instance
    @bookmarks = Bookmark
  end

  get '/' do
    redirect '/bookmarks'
  end

  get '/bookmarks' do
    erb :bookmarks
  end

  post '/bookmarks' do
    Bookmark.add_bookmark(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(params[:id])
    redirect '/bookmarks'
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  run! if app_file == $PROGRAM_NAME
end
