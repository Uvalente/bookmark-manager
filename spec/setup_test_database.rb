# frozen_string_literal: true

require 'pg'

def setup_test_database
  database = PG.connect(dbname: 'bookmark_manager_test')

  database.exec('TRUNCATE bookmarks;')
end
