letters = ["a","e","i","o","u","y"]
hash = {}
('a'..'z').each_with_index{|value, key| hash[value] = key+1 if letters.include? value}
puts hash