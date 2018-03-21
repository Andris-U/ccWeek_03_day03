require('pg')
require_relative('../sql_runner')

class Artist
  attr_accessor :name
  attr_reader :id

  def initialize options
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = "
      INSERT INTO artists (name)
      VALUES ($1)
      RETURNING id;
    "
    @id = SqlRunner.run(sql, [@name]).first['id']
  end

  def self.list_all
    sql = "
      SELECT * FROM artists;
    "
    list = SqlRunner.run(sql)
    return list.map { |e| Artist.new(e) } if list.first != nil
    return nil
  end

  def self.all_albums artist
    sql = "
      SELECT * FROM albums
      WHERE artist_id = $1;
    "
    values = [artist]
    list = SqlRunner.run sql, values
    return list.map { |e| Album.new(e) } if list.first != nil
    return nil
  end

  def self.delete_all
    sql = "
      DELETE FROM artists;
    "
    SqlRunner.run(sql)
  end

end
