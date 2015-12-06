module EnvContext
  def self.with setting
    puts "context checking #{setting}"
    ENV[setting] and begin
      puts "contxt found #{setting}: #{ENV[setting]}"
      yield ENV[setting]
      return
    end
    puts "context did not find setting: #{setting}"
  end
end
