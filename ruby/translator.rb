require_relative './translator_dictionary'

# Braille Translator
# author: Andressa Machado
# date: 30-Aug-2024
# version: 1.0

# Class to perform translation between Braille and English
class Translator
  include TranslatorDictionary

  private
  attr_reader :format, :input

  public
  def initialize(input)
    (raise ArgumentError, 'Please, provide a valid input!') if !input_validation(input)

    @format = check_format(input)
    @input = prepare_input(input)
  end

  def translate
    format == 'braille' ? braille_to_english : english_to_braille
  end

  private
  # Method to perform basic input validation
  def input_validation(input)
    return false if input.empty?
    input.match?(/[A-Z0-9]/i) ? true : false
  end

  # Method to check if it is a Braille or English text input
  def check_format(input)
    # we don't check for "O" as For Braille, each character is stored as a series of "O" or "." (a period).
    input.match?(/[A-NP-Z0-9]/i) ? 'text' : 'braille'
  end

  # Method to prepare input for translation
  def prepare_input(input)
    # if Braille, slice the input into an array of strings of 6 characters long
    # if English text, split the input into an array of characters
    format == 'braille' ? input.scan(/.{6}/) : input.chars
  end

  # Method to translate Braille to English text
  def braille_to_english
    # flag used to indicate that the next sequences are numbers
    # or, when set to false, indicate that next sequences are letters
    is_number = false
    index = 0

    # go through the input array and translate each sequence to respective character
    input.reduce([]) do |result, sequence|
      # if the sequence is a rule, check the rule and translate the next sequence accordingly
      # otherwise, translate the sequence to a character
      if (TranslatorDictionary::BRAILLE_RULES[sequence])
        case TranslatorDictionary::BRAILLE_RULES[sequence]
        when 'uppercase'
          next_sequence = input[index += 1]
          result << TranslatorDictionary::BRAILLE_ALPHABET[next_sequence].upcase
        when 'number'
          is_number = true
          result << TranslatorDictionary::BRAILLE_DIGITS[input[index]]
        end
      else
        if (is_number)
          result << TranslatorDictionary::BRAILLE_DIGITS[input[index]]
        else
          result << TranslatorDictionary::BRAILLE_ALPHABET[input[index]]
        end
      end

      index += 1
      result
    end.join
  end

  # Method to translate English text to Braille
  def english_to_braille
    is_number = false
    result = []

    # go through the input array and translate each char to respective sequence
    input.each_with_index do |char, index|
      if (char.match?((/[A-Z]/)))
        result << TranslatorDictionary::BRAILLE_RULES.key('uppercase')
        result << TranslatorDictionary::BRAILLE_ALPHABET.key(char.downcase)
      end

      # !is_number is used to avoid adding the number rule multiple times
      if (char.match?((/[0-9]/)) && !is_number)
        is_number = true
        result << TranslatorDictionary::BRAILLE_RULES.key('number')
      end

      # reset letters sequence
      if (char.match?(' '))
        is_number = false
      end

      if (is_number)
        result << TranslatorDictionary::BRAILLE_DIGITS.key(char)
      else
        result << TranslatorDictionary::BRAILLE_ALPHABET.key(char)
      end
    end

    result.join
  end
end

# Get user input from command line
 user_input = ARGV.join(' ')
 puts Translator.new(user_input).translate
