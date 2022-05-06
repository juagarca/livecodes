require 'yaml'
require_relative 'scraper'

# Scrape imdb to get URLs
puts 'Fetching URLs...'
urls = fetch_movie_urls

# Loop over those URLs and scrape urls
puts 'Scraping urls...'
movies = urls.map do |url|
  puts "Scraping #{url}"
  scrape_movie(url)
end

# Convert the Array of movies into a YAML and write it to a file
puts 'Writing movies.yml'
File.open('movies.yml', 'w') do |f|
  f.write(movies.to_yaml)
end

puts 'Done'
