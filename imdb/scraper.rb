require 'open-uri'
require 'nokogiri'

def fetch_movie_urls
  url = 'https://www.imdb.com/chart/top'

  html_doc_serialized = URI.open(url).read
  html_doc = Nokogiri::HTML(html_doc_serialized)
  movies = html_doc.search('.titleColumn a')
  result = []

  movies[0..4].each do |movie|
    path = movie.attributes['href'].value
    result << "https://www.imdb.com#{path}"
  end
  result
end

def scrape_movie(url)
  doc_serialized = URI.open(url).read
  doc = Nokogiri::HTML(doc_serialized)

  # Put the movie information into a Hash
  title = doc.search('h1').text
  year = doc.search('.sc-8c396aa2-2').first.text.to_i
  storyline = doc.search('.sc-16ede01-0').first.text
  director = doc.search('.ipc-metadata-list__item:contains("Director") a').first.children.text
  cast = doc.search('.sc-11eed019-1').map do |actor|
    actor.children.text
  end

  {
    title: title,
    cast: cast,
    director: director,
    storyline: storyline,
    year: year
  }
end
