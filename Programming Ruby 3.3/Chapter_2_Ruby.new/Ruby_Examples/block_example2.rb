def who_says_what
  yield("Dave", "Hello")
  yield("Andy", "Hi")
end

who_says_what { |person, phrase| puts "#{person} says #{phrase}" }
