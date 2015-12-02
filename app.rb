$:.unshift File.dirname(__FILE__)
puts "starting app"

puts "loading me"
require 'me'

# we have been started, there may or may not be more of me
me = Me.new

# now i wait
me.exist!
