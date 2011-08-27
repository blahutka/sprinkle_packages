Dir[File.dirname(__FILE__) + "/packages/**/*.rb"].each do |file|
  puts '** loading ' + file
  require file
end