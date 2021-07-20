print "Добрый день! Введите Ваше имя: "
name = gets.strip
print "Введите Ваш рост в сантиметрах: "
height = gets.strip.to_f
ideal_weight = (height-110)*1.15
    if ideal_weight <= 0
	puts "Ваш вес уже оптимальный"
	else puts "Ваш целевой вес #{ideal_weight.round(2)} кг"
    end