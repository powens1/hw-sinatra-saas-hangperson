class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess (letter)
    if letter.to_s == '' or letter[/[^a-zA-Z]+/]
      return raise ArgumentError.new
    end
    
    letter.downcase!
    
    if @word.include?(letter)
      if @guesses.include?(letter)
        false
      else
        @guesses << letter 
      end
    else
      if @wrong_guesses.include?(letter)
        false
      else
        @wrong_guesses << letter 
      end
    end
  end
  
  def word_with_guesses
    word_with_dashes = ''
    @word.each_char do |x|
      if @guesses.include? x 
        word_with_dashes << x
      else
        word_with_dashes << '-'
      end
    end
    return word_with_dashes
  end
  
  def check_win_or_lose
    if @wrong_guesses.length >= 7
      return :lose
    elsif word_with_guesses == @word
      return :win
    else
      return :play
    end
  end

end
