# frozen_string_literal: true

# Module to hold a dictionary containg the braille alphabet and digits
module TranslatorDictionary
  BRAILLE_ALPHABET = {
    'O.....' => 'a', 'O.O...' => 'b', 'OO....' => 'c',
    'OO.O..' => 'd', 'O..O..' => 'e', 'OOO...' => 'f',
    'OOOO..' => 'g', 'O.OO..' => 'h', '.OO...' => 'i',
    '.OOO..' => 'j', 'O...O.' => 'k', 'O.O.O.' => 'l',
    'OO..O.' => 'm', 'OO.OO.' => 'n', 'O..OO.' => 'o',
    'OOO.O.' => 'p', 'OOOOO.' => 'q', 'O.OOO.' => 'r',
    '.OO.O.' => 's', '.OOOO.' => 't', 'O...OO' => 'u',
    'O.O.OO' => 'v', '.OOO.O' => 'w', 'OO..OO' => 'x',
    'OO.OOO' => 'y', 'O..OOO' => 'z', '......' => ' '
  }.freeze

  BRAILLE_DIGITS = {
    'O.....' => '1', 'O.O...' => '2', 'OO....' => '3',
    'OO.O..' => '4', 'O..O..' => '5', 'OOO...' => '6',
    'OOOO..' => '7', 'O.OO..' => '8', '.OO...' => '9',
    '.OOO..' => '0'
  }.freeze

  # Contains sentence building directions
  BRAILLE_RULES = {
    '.....O' => 'uppercase', '.O...O' => 'decimal', '.O.OOO' => 'number'
  }.freeze
end
