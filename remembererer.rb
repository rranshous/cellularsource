require 'thread'

class Remembererer
  def self.remind_me defer_for, obj, msg
    puts "reminder settings reminder for #{defer_for} seconds " +
         "from now :#{msg} => #{obj}"
    Thread.new do
      sleep defer_for
      puts "reminder sending :#{msg} => #{obj}"
      obj.send msg
    end
  end
end
