import Foundation

struct Order {
    
    // Хранимое свойство "Заказ"
    var order: [Food: Int] = [:]
    
    // Вычисляемое свойство "Итоговая цена"
    var totalPrice: Int {
        var total: Int = 0
        if !order.isEmpty {
            for (food, count) in order {
                total += ( food.price * count )
            }
        }
        return total
    }
    
    // Метод "Добавить блюдо к заказу"
    mutating func addToOrder(foodPosition: Food) {
        if !order.contains(where: { (food, count) in
            food == foodPosition
        }) {
            order[foodPosition] = 1
        } else {
            order[foodPosition]! += 1
        }
    }
    
    // Метод "Удалить блюдо из заказа"
    mutating func removeFromOrder(foodPosition: Food) {
        if order.contains(where: { (food, count) in
            food == foodPosition
        }) {
            if order[foodPosition] == 1 {
                order[foodPosition] = nil
            } else {
                order[foodPosition]! -= 1
            }
        }
    }
    
}
