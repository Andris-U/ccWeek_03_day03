require('pg')
require('pry')
require_relative('../sql_runner')

class Album
  attr_accessor :title, :genre
  attr_reader :artist_id

  def initialize options
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save
    sql = "
      INSERT INTO albums (title, genre, artist_id)
      VALUES ($1, $2, $3)
      RETURNING id;
    "
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def artist
    sql = "
      SELECT * FROM artists
      WHERE id = $1;
    "
    values = [@artist_id]
    list = SqlRunner.run sql, values
    return list.first['name'] if list.first
    return nil
  end

  def self.list_all
    sql = "
      SELECT * FROM albums;
    "
    list = SqlRunner.run sql
    return list.map { |e| Album.new(e) } if list.first != nil
    return nil
  end

  def self.delete_all
    sql = "
      DELETE FROM albums;
    "
    SqlRunner.run(sql)
  end

end
