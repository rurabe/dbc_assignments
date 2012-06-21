# Dependencies
require "csv"
require 'sunlight'



# Class Definition
class EventManager
  INVALID_ZIPCODE = "00000"
  INVALID_PHONE_NUMBER = "0000000000"
  Sunlight::Base.api_key = "e179a6973728c4dd3fb1204283aaccb5"

  def initialize(filename)
    puts "EventManager Initialized."
    @file = CSV.open(filename, {:headers => true, :header_converters => :symbol})
  end

  def print_names
    @file.each do |line|
      puts line[:first_name] + " " + line[:last_name]
    end
  end

  def print_numbers
    @file.each do |line|
      puts clean_number(line[:homephone])
    end
  end

  def clean_number(original_number)
    clean_number = original_number.gsub(/\D/,"")
    if clean_number.length == 10
      clean_number
    elsif clean_number.length == 11
      if clean_number.start_with?("1")
        clean_number = clean_number[1..-1]
      else
        clean_number = INVALID_PHONE_NUMBER
      end
    else
      clean_number = INVALID_PHONE_NUMBER
    end
    clean_number
  end

  def print_zip_codes
    @file.each do |line|
      puts clean_zip_codes(line[:zipcode]) + " " + line[:zipcode].to_s
    end
  end

  def clean_zip_codes(original_zip_code)
    clean_zip = original_zip_code.to_s.rjust(5,"0")
  end

  def output_data(filename)
    output = CSV.open(filename, "w")
    @file.each do |line|
      if @file.lineno == 2
        output << line.headers
      else
        line[:homephone] = clean_number(line[:homephone])
        line[:zipcode] = clean_zip_codes(line[:zipcode])
        output << line
      end
    end
    puts "output complete"
  end

  def rep_lookup
    20.times do
      line = @file.readline
      legislators = Sunlight::Legislator.all_in_zipcode(clean_zip_codes(line[:zipcode]))
      names = legislators.collect do |leg|
        first_name = leg.firstname
        first_initial = first_name[0]
        last_name = leg.lastname
        leg.title + " " + first_initial + ". " + last_name + " (" + leg.party + ")"
      end
      puts "#{line[:last_name]}, #{line[:first_name]}, #{line[:zipcode]}, #{names.join(", ")}"
    end
  end
end

# Script
manager = EventManager.new("event_attendees.csv")
manager.rep_lookup

