require 'httparty'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    session[:letters] = @letters
  end

  def score
    @word = params[:word]
    @letters = session[:letters] || []
    @result = check_word(@word, @letters)
  end

  private

 def check_word(word, letters)
    word_array = word.upcase.split("")

    # Check if the word can be formed from the given letters
    word_array.each do |letter|
        if word_array.count(letter) > letters.count(letter)
            return "Sorry but '#{word}' can't be built out of #{letters}"
        end
    end

    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = HTTParty.get(url)
    json = JSON.parse(response.body)
    if json["found"] == false
      return "Sorry but '#{word}' does not seem to be a valid English word..."
    else
      return "Congratulations! '#{word}' is a valid English word!"
    end
end

end
