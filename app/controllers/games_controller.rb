require 'httparty'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @result = check_word(@word, @letters)
  end

  private

  def check_word(word, letters)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = HTTParty.get(url)
    json = JSON.parse(response.body)
    if json["found"] == false
      return "Sorry but #{word} does not seem to be a valid English word..."
    else
      return "Congratulations! #{word} is a valid English word!"
    end
  end
end
