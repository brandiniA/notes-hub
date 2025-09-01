# This program acts as an "echo" - reads line by line from standard input
# and prints them back. Stops when Ctrl+D (EOF) is pressed

puts "Type something (Ctrl-D to quit):"

while (line = gets)
  puts "You said: #{line.chomp}"
end

puts "Goodbye!"