require('pg')
require('pry')
require_relative('models/artist')
require_relative('models/album')

Album.delete_all
Artist.delete_all

art_op1 = Artist.new({
  'name' => 'Daft Punk'
})

art_op1.save

album1ops = Album.new({
  'title' => 'Homework',
  'genre' => 'House',
  'artist_id' => art_op1.id
})

album1ops.save

p Artist.list_all
p Artist.all_albums art_op1.id

p album1ops.artist

art_op1.name = 'Paft Dunk'
art_op1.update

p Artist.list_all

album1ops.title = 'Hamework'
album1ops.update

p Album.list_all
p Artist.find_by_id art_op1.id

Album.delete_by_title 'Hamework'
Artist.delete_artist 'Paft Dunk'

p Album.list_all
p Artist.list_all
