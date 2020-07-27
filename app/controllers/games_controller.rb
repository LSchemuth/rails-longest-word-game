require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @grid = params[:grid].split(' ')
    @included = letter_in_grid?(@word, @grid)
    @english_word = english_word?(@word)
  end

  private

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_dictionary = open(url)
    json = JSON.parse(word_dictionary.read)
    return json['found']
  end

  def letter_in_grid?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
