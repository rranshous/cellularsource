puts "starting app"

puts "loading me"
require_relative 'me'

# we have been started, there may or may not be more of me
me = Me.new

# now i wait
me.exist!
