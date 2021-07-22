busket = {}
sum = Hash.new
name = ''

loop  do
print "Введите название товара: "
name = gets.strip
    if name != 'stop'
        print "Введите цену товара: "
        price = gets.chomp.to_f
        print "Введите количество товара: "
        quant = gets.chomp.to_f
        sum = {price => quant}
        busket [name] = sum  
         
    else break
    end

end


total = 0

busket.each do |name, value|
    value.each do 
        |quant, price| puts "Наименование:\t#{name}\tколичество:\t#{quant}\tцена:\t#{price}\tстоимость:\t#{quant*price}"   
        total = total + quant*price
    end
end
puts "Всего в корзине товаров на #{total}"