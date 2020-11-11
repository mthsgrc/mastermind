#!/usr/bin/env ruby
require "pry"

require_relative "./string_mod.rb"
require_relative "./logic.rb"
# require_relative "./codebreaker.rb"
# require_relative "./codemaker.rb"
# require_relative "./checkguess_module.rb"


class Match < GameLogic
  
  attr_accessor :play_board
  def initialize
    print welcome_message
    puts
    print "To start, insert the name of Codebreaker Player: "
    codebreaker_name = gets.chomp
    @codebreaker = CodeBreaker.new(codebreaker_name.to_s)
    puts
    print "Who will create the secret code:\n(C)omputer o another (P)layer?\n"
    codemaker_name = gets.chomp.upcase!

    until codemaker_name == "C" || codemaker_name == "P"
      print "(C)omputer o another (P)layer?\n"
      codemaker_name = gets.chomp.upcase!
    end

    if codemaker_name == "P"
      print "Insert name of Codemaker Player: "
      codemaker_name = gets.chomp
    end

    codemaker_name == "C" ? @codemaker = CodeMaker.new : @codemaker = CodeMaker.new(codemaker_name)
    system ('clear')
    @play_board = DecodingBoard.new
    start_match
  end
end

Match.new
