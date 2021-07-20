puts "Проверим является ли треугольник прямоугольным, равносторонним, равнобедренным"

sides = []

3.times do |i|
    print "Введите длину #{i+1} стороны треугольника "
    sides[i] = gets.chomp.to_f
end

sides.sort!
sides.reverse!
sides.map! {|i|i**2}

if sides [0] == sides[1] + sides [2]
    puts "Треугольник прямоугольный"
end

if sides[0] == sides[1] && sides[1] == sides [2]
	puts "Треугольник равносторонний и равнобедренный"
    exit
    elsif sides[0] == sides[1] || sides[1] == sides [2]
	puts "Треугольник равносторонний"
end

puts "Проверка проведена"