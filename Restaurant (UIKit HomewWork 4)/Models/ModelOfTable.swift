import Foundation

class Table: Hashable {
    
    // Реализация подписки на протокол "Hashable"
    /* - - - - - - - - - - - - - - - - - - - - */
    static func == (lhs: Table, rhs: Table) -> Bool {
        return ( (lhs.numberOfTable == rhs.numberOfTable)
                 && (lhs.isFree == rhs.isFree)
                 && (lhs.isChoosen == rhs.isChoosen) )
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.numberOfTable)
        hasher.combine(self.isFree)
        hasher.combine(isChoosen)
    }
    /* - - - - - - - - - - - - - - - - - - - - */
    
    // Хранимые свойства
    let numberOfTable: Int
    var isFree: Bool = false
    var isChoosen: Bool = false
    
    //Вычисляемые свойства
    var isReserved: Bool {
        return !isFree
    }
    
    // Метод "Забронировать стол"
    func chooseTheTable() {
        if self.isFree {
            self.isChoosen = true
            self.isFree = false
        }
    }
    
    // Метод "Освободить стол"
    func vacateTheTable() {
        self.isFree = true
        self.isChoosen = false
    }
    
    // Инициализатор
    init(numberOfTable: Int) {
        self.numberOfTable = numberOfTable
    }

}

