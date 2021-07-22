# функция определения высокосного года
def is_year_leap? year
    if year %100 ==0 && year%400 == 0
        return true
    end
    if year %4 == 0 
      return  true
    end    
   false 
end




print "Введите год: "
year = gets.chomp.to_i

print "Введите номер месяца (1 - 12): "
mounth = gets.chomp.to_i

print "Введите дату: "
date = gets.chomp.to_i

# хэш с колличеством денй в месяце

year_hash = {
    1 => 31, 
    2 => 28, 
    3 => 31,
    4 => 30, 
    5 => 31, 
    6 => 30, 
    7 => 31, 
    8 => 31, 
    9 => 30, 
    10 => 31, 
    11 => 30, 
    12 => 31}

# если год высокосный во втором месяце колличество дней меняем на 29
if is_year_leap? year
    year_hash[2] = 29 
end

# считаем порядковый номер даты в году
a = 0
year_hash.each {|mounth_key, days| a = a + days if mounth_key < mounth}
number = a + date

puts number