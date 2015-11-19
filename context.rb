require_relative 'smart_nil'

module EnvContext
  def self.with setting
    puts "context checking #{setting}"
    ENV[setting].and do
      puts "contxt found #{setting}: #{ENV[setting]}"
      yield ENV[setting]
      return
    end
    puts "context did not find setting: #{setting}"
  end
end
