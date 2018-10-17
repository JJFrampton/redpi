#!/usr/bin/env ruby

# text_content = "Text to run sentiment analysis on"

require "google/cloud/language"

language = Google::Cloud::Language.new

response = language.analyze_sentiment content: text_content, type: :PLAIN_TEXT

sentiment = response.document_sentiment

puts "Overall document sentiment: (#{sentiment.score})"
puts "Sentence level sentiment:"

sentences = response.sentences

sentences.each do |sentence|
  sentiment = sentence.sentiment
  puts "#{sentence.text.content}: (#{sentiment.score})"
end
