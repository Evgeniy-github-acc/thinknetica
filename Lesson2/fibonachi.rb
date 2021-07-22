arr = [0]
a = 1
i = 0
while a < 100 do
   i += 1
   arr[i] = a
   a = arr[i] + arr[i-1]
end
puts arr