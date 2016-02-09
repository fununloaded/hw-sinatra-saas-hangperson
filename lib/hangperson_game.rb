class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  attr_accessor :word, :wrong_guesses, :guesses
  
  def guess(letter)
    if !(letter =~ /[a-zA-Z]/)
      raise ArgumentError
    end
    letter.each_char do |i|
      if (@guesses.include? i) || (@wrong_guesses.include? i) || (/[[:upper:]]/.match(i))
        return false
      else
        if @word.include? i
          @guesses << i
        else
          @wrong_guesses << i
        end
      end
    end
  end
  
  def self.guesses
    puts @guesses
  end
  
  def self.wrong_guesses
    puts @wrong_guesses
  end
  
  def word_with_guesses
    format_word = @word
    format_word.each_char do |i|
      if !(@guesses.include? i)
        format_word.gsub!(i, "-")
      end
    end
    return format_word
  end

  def check_win_or_lose
    if @wrong_guesses.length == 7
      return :lose
    end
    if (guesses.size == @word.size) && (guesses.each_char.sort == @word.each_char.sort)
      return :win
    end
    return :play
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
