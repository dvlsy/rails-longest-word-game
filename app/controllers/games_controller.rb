require "open-uri"
class GamesController < ApplicationController
  def new
    # Pick 10 random uppercase letters
    @letters = Array.new(10) { ("A".."Z").to_a.sample }
  end

  def in_grid?(word, grid)
    word.chars.all? { |ltr| word.count(ltr) <= grid.count(ltr) }
  end
def score
  @letters = params[:letters].split(" ")

  @word = params[:word].to_s.upcase



  unless in_grid?(@word, @letters)
    @result = "❌ “#{@word}” can’t be built from #{@letters.join(' ')}"
    return
  end

  url  = "https://dictionary.lewagon.com/#{@word}"
  data = JSON.parse(URI.open(url).read)

  if data["found"]
    @result = "✅ “#{@word}” is valid English (#{data['length']} letters)!"
  else
    @result = "❌ “#{@word}” is not a valid English word."
  end
end
end
