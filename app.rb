require_relative 'me'

puts "starting app"

# we have been started, there may or may not be more of me
me = Me.new

# now i wait
me.exist!
