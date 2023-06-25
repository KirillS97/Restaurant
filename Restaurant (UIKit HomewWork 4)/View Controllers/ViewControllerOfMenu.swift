import UIKit

class ViewControllerOfMenu: UIViewController {
    
    typealias MenuPosition = (nameLabel: UILabel,
                              priceLabel: UILabel,
                              countLabel: UILabel,
                              stepper: UIStepper)
    
    
    
    // MARK: - Хранимые свойства
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    var titleLabel: UILabel!
    var nameTitleLabel, priceTitleLabel, countTitleLabel: UILabel!
    var totalPriceLabel: UILabel!
    
    var borsch, solyanka, caesar, olivie: Food!
    var dictionaryOfMenuPosition: [Food: MenuPosition] = [:]
    var arrayOfMenuPosition: [Food] = []  // Данный массив используется для добавления метки "total price label" после самого последнего элемента массива. Добавление блюда в массив происходит во время исполнения функции "createNewPosition", добавляющей блюдо на экран.
    
    var order: Order! = Order()
    
    var confirmButton: UIButton!
    
    var closureForOrderTransfer: ((Order?) -> Void)?
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - "viewDidLoad" method
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // MARK: Настройка корневого вью
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.view.backgroundColor = viewColor
        
        let widthOfRootView = self.view.frame.width
        let heightOfRootView = self.view.frame.height
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Заголовочная метка "Меню"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.titleLabel = UILabel()
        
        // Создание метки
        createLabel(rootView: self.view, label: self.titleLabel, text: "Menu", numberOfLines: 1, fontSize: nil, fontWeight: .semibold, textColor: nil, isCenterTextAlignment: true)
        
        // Изменение шрифта метки
        self.titleLabel.font = .init(name: "Zapfino", size: labelTitleFontSizeFactor * iPhone14SceneDiagonal)
        
        // Добавление объекта к корневому вью
        self.view.addSubview(self.titleLabel)
        
        // Отключение автоматических ограничений
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Метка "Блюдо"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.nameTitleLabel = UILabel()
        
        // Создание метки
        createLabel(rootView: self.view, label: self.nameTitleLabel, text: "Блюдо", fontWeight: .semibold, isCenterTextAlignment: true)
        
        // Добавление объекта к корневому вью
        self.view.addSubview(self.nameTitleLabel)
        
        // Отключение автоматических ограничений
        self.nameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Расстояние от базового элемента до левого края метки с названием блюда (для iPhone 14)
        let leftAnchorOfNameTitleLabel: CGFloat = 10
        
        // Ширина метки с названием блюда (для iPhone 14)
        let widthOfNameTitleLabel: CGFloat = 165
        
        // Расстояние от базового элемента до верхнего края метки с названием блюда (для iPhone 14)
        let topAnchorOfNameTitleLabel: CGFloat = 0
        
        // Ограничения для метки с названием блюда
        let constraintForLeftAnchorOfNameLabel = (leftAnchorOfNameTitleLabel / iPhone14SceneWidth) * widthOfRootView
        let constraintForWidthOfNameLabel = (widthOfNameTitleLabel / iPhone14SceneWidth) * widthOfRootView
        let constraintForTopAnchorOfNameLabel = (topAnchorOfNameTitleLabel / iPhone14SceneHeight) * heightOfRootView
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.nameTitleLabel.widthAnchor.constraint(equalToConstant: constraintForWidthOfNameLabel),
            self.nameTitleLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor,
                                                      constant: constraintForLeftAnchorOfNameLabel),
            self.nameTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,
                                                     constant: constraintForTopAnchorOfNameLabel)
        ])
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Метка "Цена"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.priceTitleLabel = UILabel()
        
        // Создание метки
        createLabel(rootView: self.view, label: self.priceTitleLabel, text: "Цена", fontWeight: .semibold, isCenterTextAlignment: true)
        
        // Добавление объекта к корневому вью
        self.view.addSubview(self.priceTitleLabel)
        
        // Отключение автоматических ограничений
        self.priceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Расстояние от базового элемента до левого края метки с ценой блюда (для iPhone 14)
        let leftAnchorOfPriceTitleLabel: CGFloat = 10
        
        // Ширина метки с ценой блюда (для iPhone 14)
        let widthOfPriceTitleLabel: CGFloat = 52
        
        // Ограничения для метки с ценой блюда
        let constraintForLeftAnchorOfPriceTitleLabel = (leftAnchorOfPriceTitleLabel / iPhone14SceneWidth) * widthOfRootView
        let constraintForWidthOfPriceTitleLabel = (widthOfPriceTitleLabel / iPhone14SceneWidth) * widthOfRootView
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.priceTitleLabel.widthAnchor.constraint(equalToConstant: constraintForWidthOfPriceTitleLabel),
            self.priceTitleLabel.leftAnchor.constraint(equalTo: self.nameTitleLabel.rightAnchor,
                                                      constant: constraintForLeftAnchorOfPriceTitleLabel),
            self.priceTitleLabel.centerYAnchor.constraint(equalTo: self.nameTitleLabel.centerYAnchor)
        ])
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Метка "Кол-во"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.countTitleLabel = UILabel()
        
        // Создание метки
        createLabel(rootView: self.view, label: self.countTitleLabel, text: "", fontWeight: .semibold, isCenterTextAlignment: true)
        
        // Добавление объекта к корневому вью
        self.view.addSubview(self.countTitleLabel)
        
        // Отключение автоматических ограничений
        self.countTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Расстояние от базового элемента до левого края метки с ценой блюда (для iPhone 14)
        let leftAnchorOfCountTitleLabel: CGFloat = 10
        
        // Ширина метки с количеством (для iPhone 14)
        let widthOfCountTitleLabel: CGFloat = 30
        
        // Ограничения для метки с количеством блюд
        let constraintForLeftAnchorOfCountTitleLabel = (leftAnchorOfCountTitleLabel / iPhone14SceneWidth) * widthOfRootView
        let constraintForWidthOfCountTitleLabel = (widthOfCountTitleLabel / iPhone14SceneWidth) * widthOfRootView
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.countTitleLabel.widthAnchor.constraint(equalToConstant: constraintForWidthOfCountTitleLabel),
            self.countTitleLabel.leftAnchor.constraint(equalTo: self.priceTitleLabel.rightAnchor,
                                                      constant: constraintForLeftAnchorOfCountTitleLabel),
            self.countTitleLabel.centerYAnchor.constraint(equalTo: self.priceTitleLabel.centerYAnchor)
        ])
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка графических элементов позиций блюд
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        //Инициализация объектов блюд
        borsch = Food(name: "Борщ", price: 350)
        solyanka = Food(name: "Солянка", price: 350)
        caesar = Food(name: "Салат \"Цезарь\"", price: 450)
        olivie = Food(name: "Салат \"Оливье\"", price: 300)
        
        // Настройка графических элементов позиций блюд
        createNewPosition(food: borsch,
                          baseElementForPositioning: self.nameTitleLabel.bottomAnchor,
                          verticalDistanceFromBaseElement: 30)
        
        createNewPosition(food: solyanka,
                          baseElementForPositioning: self.dictionaryOfMenuPosition[borsch]!.nameLabel.bottomAnchor,
                          verticalDistanceFromBaseElement: 20)
        
        createNewPosition(food: caesar,
                          baseElementForPositioning: self.dictionaryOfMenuPosition[solyanka]!.nameLabel.bottomAnchor,
                          verticalDistanceFromBaseElement: 20)
        
        createNewPosition(food: olivie,
                          baseElementForPositioning: self.dictionaryOfMenuPosition[caesar]!.nameLabel.bottomAnchor,
                          verticalDistanceFromBaseElement: 20)
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Метка "Общий счёт"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.totalPriceLabel = UILabel()
        
        // Настройка метки
        createLabel(rootView: self.view, label: self.totalPriceLabel, text: "Общий счёт: \(order.totalPrice)", fontWeight: .semibold, isCenterTextAlignment: false)
        
        // Добавление метки к корневому вью
        self.view.addSubview(self.totalPriceLabel)
        
        // Отключение автоматических ограничений
        self.totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.totalPriceLabel.leftAnchor.constraint(equalTo:
                                                        dictionaryOfMenuPosition[self.arrayOfMenuPosition.last!]!.nameLabel.leftAnchor),
            self.totalPriceLabel.topAnchor.constraint(equalTo:
                                                        dictionaryOfMenuPosition[self.arrayOfMenuPosition.last!]!.nameLabel.bottomAnchor,
                                                      constant: 50)
        ])
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Кнопка "Подтвердить"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация
        self.confirmButton = UIButton()
        
        // Настройка кнопки
        createButton(rootView: self.view, button: self.confirmButton, title: "Подтвердить")
        
        // Добавление кнопки к корневому вью
        self.view.addSubview(self.confirmButton)
        
        // Отключение автоматических ограничений
        self.confirmButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.confirmButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.confirmButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                                       constant: -(100 * heightOfRootView) / iPhone14SceneHeight),
            self.confirmButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor,
                                                     constant: (50 * widthOfRootView) / iPhone14SceneWidth)
        ])
        
        // Добавление обработчика нажатия
        self.confirmButton.addTarget(self, action: #selector(saveOrderAndGoBack), for: .touchUpInside)
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
    }
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: "viewWillAppar" method
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for (food, menuPosition) in dictionaryOfMenuPosition {
            if order.order.contains(where: { (orderedFood, count) in
                orderedFood == food
            }) {
                menuPosition.stepper.value = Double(order.order[food]!)
                menuPosition.countLabel.text = String(Int(menuPosition.stepper.value))
            } else {
                menuPosition.stepper.value = 0
                menuPosition.countLabel.text = String(0)
            }
        }
        self.totalPriceLabel.text = "Общий счёт: \(order.totalPrice)"
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Функция создания новой позиции в меню
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    func createNewPosition(food: Food,
                           baseElementForPositioning: NSLayoutYAxisAnchor,
                           verticalDistanceFromBaseElement: CGFloat) {
        
        // MARK: Инициализация и первоначальная настройка графических элементов
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Метка с названием блюда
        let nameLabel = UILabel()
        createLabel(rootView: self.view, label: nameLabel, text: (food.name), numberOfLines: 2, isCenterTextAlignment: false)
        
        // Метка со стоимостью блюда
        let priceLabel = UILabel()
        createLabel(rootView: self.view, label: priceLabel, text: "\(food.price)", isCenterTextAlignment: true)
        
        // Метка с количеством заказанного блюда
        let countLabel = UILabel()
        createLabel(rootView: self.view, label: countLabel, text: "0", isCenterTextAlignment: true)
        
        // Степпер
        let stepper = UIStepper()
        stepper.stepValue = 1
        stepper.minimumValue = 0
        stepper.maximumValue = 21
        stepper.addTarget(self, action: #selector(changeTheFoodCount(sender:)), for: .valueChanged)
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Добавление графических элементов к корневому вью
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.view.addSubview(nameLabel)
        self.view.addSubview(priceLabel)
        self.view.addSubview(countLabel)
        self.view.addSubview(stepper)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Отключение автоматических ограничений
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        stepper.translatesAutoresizingMaskIntoConstraints = false
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Добавление графических элементов в словарь с позициями меню
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.dictionaryOfMenuPosition[food] = (nameLabel: nameLabel,
                                               priceLabel: priceLabel,
                                               countLabel: countLabel,
                                               stepper: stepper)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Ограничения для выравнивания графических элементов
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Метка с названием блюда
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: self.nameTitleLabel.safeAreaLayoutGuide.leftAnchor),
            nameLabel.widthAnchor.constraint(equalTo: self.nameTitleLabel.widthAnchor,
                                             multiplier: 1),
            nameLabel.topAnchor.constraint(equalTo: baseElementForPositioning,
                                           constant: verticalDistanceFromBaseElement)
        ])
        
        // Метка с ценой блюда
        NSLayoutConstraint.activate([
            priceLabel.leftAnchor.constraint(equalTo: self.priceTitleLabel.leftAnchor),
            priceLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            priceLabel.widthAnchor.constraint(equalTo: self.priceTitleLabel.widthAnchor,
                                              multiplier: 1)
        ])
        
        // Метка с количеством блюд
        NSLayoutConstraint.activate([
            countLabel.leftAnchor.constraint(equalTo: self.countTitleLabel.leftAnchor),
            countLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            countLabel.widthAnchor.constraint(equalTo: self.countTitleLabel.widthAnchor,
                                              multiplier: 1)
        ])
        
        // Степпер
        NSLayoutConstraint.activate([
            stepper.leftAnchor.constraint(equalTo: countLabel.rightAnchor,
                                          constant: ( (10 / iPhone14SceneWidth) * self.view.frame.width )),
            stepper.centerYAnchor.constraint(equalTo: countLabel.centerYAnchor),
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Добавление блюда в массив блюд
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.arrayOfMenuPosition.append(food)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
    }
    
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик нажатия на степперы
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    @objc func changeTheFoodCount(sender: UIStepper) {
        for (food, menuPosition) in dictionaryOfMenuPosition {
            if menuPosition.stepper === sender {
                if Int(menuPosition.stepper.value) > Int(menuPosition.countLabel.text!)! {
                    self.order.addToOrder(foodPosition: food)
                } else {
                    self.order.removeFromOrder(foodPosition: food)
                }
                menuPosition.countLabel.text = String(Int(menuPosition.stepper.value))
                self.totalPriceLabel.text = "Общий счёт: \(order.totalPrice)"
            }
        }
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик нажатия на кнопку "Подтвердить"
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    @objc func saveOrderAndGoBack() {
        if !self.order.order.isEmpty {
            self.closureForOrderTransfer!(self.order)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    
    
}
