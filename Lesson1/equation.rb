print "Введите коэфициент a уравнения: "
a = gets.chomp.to_f
print "Введите коэфициент b уравнения: "
b = gets.chomp.to_f
print "Введите коэфициент c уравнения: "
c = gets.chomp.to_f

d = (b**2) - (4*a*c)

x_first = 0
x_second = 0

if d < 0
    puts "Дискриминант равен #{d}, уравнение не имеет корней"
elsif d == 0 
    x_first = (b * -1) / (a * 2)
    puts "Дискриминант равен #{d}, корень уравнения один и равен #{x_first}"
else
    x_first = (b * -1) + Math.sqrt(d) / (a * 2)
    x_second = (b * -1) - Math.sqrt(d) / (a * 2)
    puts "Дискриминант равен #{d}, корень уравнения Х1 равен #{x_first} корень уравнения Х2 равен #{x_second}"
end