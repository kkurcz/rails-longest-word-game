require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (Array.new((rand(5..8))) {("A".."Z").to_a.sample}) + %w[A E I O U].sample(2).to_a
  end
  def score
    # raise
    @answer = params[:answer]
    @grid = params[:letters]
    @in_grid = in_grid?
    @english_word = english_word?
    if (@english_word && @in_grid) then @result = true
    end
  end

  private

  def in_grid?
    grid_array = @grid.split('')
    attempt_array = @answer.split('')
    attempt_array.each do |letter|
      return @in_grid = false if attempt_array.count(letter) > grid_array.count(letter)
    end
  end

  def english_word?
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    doc = open(url).read
    json = JSON.parse(doc)
    @english_word = json["found"]
  end
end
