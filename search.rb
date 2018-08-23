#!/usr/bin/env ruby
require 'rubygems'
require 'nokogiri'
require 'open-uri'


keyword = gets.chomp
url = "https://www.google.co.jp/?gfe_rd=cr&ei=qWY1WJKuEamL8QfMjrHoCg&gws_rd=ssl#q="
url = URI(url+keyword)
body = Net::HTTP.get(url)
print body
