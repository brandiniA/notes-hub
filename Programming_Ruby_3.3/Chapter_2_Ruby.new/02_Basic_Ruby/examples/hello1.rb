def say_hello_goodbye_original(name)
    result = "I don't know why you say goodbye " + name + ", I say hello"
    return result
end

puts say_hello_goodbye_original("Bill")
puts say_hello_goodbye_original("John")

def say_hello_goodbye(name)
    result = "I don't know why you say goodbye #{name}, I say hello"
    return result
end

puts say_hello_goodbye("Ringo")

def say_hello_goodbye_with_capitalization(name)
    result = "I don't know why you say goodbye #{name.capitalize}, I say hello"
    return result
end

puts say_hello_goodbye_with_capitalization("john")


def say_hello_goodbye_simplified(name)
    "I don't know why you say goodbye #{name.capitalize}, I say hello"
end

puts say_hello_goodbye_simplified("Paul")
