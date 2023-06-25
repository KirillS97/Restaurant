import UIKit

class ViewControllerOfBill: UIViewController {
    
    typealias BillPosition = (nameLabel: UILabel, priceLabel: UILabel, countLabel: UILabel)
    
    
    
    // MARK: - Хранимые свойства
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    var titleLabel: UILabel!
    var nameTitleLabel, priceTitleLabel, countTitleLabel: UILabel!
    var totalPriceLabel: UILabel!
    var order: Order!
    var dictionaryOfBillPosition: [Food: BillPosition] = [:]
    var arrayOfBillPosition: [Food] = []  // Данный массив используется для добавления метки "total price label" после самого последнего элемента массива. Добавление блюда в массив происходит во время исполнения функции "createNewPosition", добавляющей блюдо на экран.
    var backgoundView: UIView!
    var confirmButton: UIButton!
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - "viewDidLoad" method
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Настройка корневогого "View"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        self.view.backgroundColor = viewColor
        
        let widthOfRootView = self.view.frame.width
        let heightOfRootView = self.view.frame.height
        let diagonalOfRootView = pow(( pow(widthOfRootView, 2) + pow(heightOfRootView, 2) ), 1/2)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Заголовочная метка "Счёт"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.titleLabel = UILabel()
        
        // Создание метки
        createLabel(rootView: self.view,
                    label: self.titleLabel,
                    text: "СЧЕТ",
                    numberOfLines: 1,
                    fontSize: labelTitleFontSizeFactor * diagonalOfRootView,
                    fontWeight: .light,
                    textColor: nil,
                    isCenterTextAlignment: true)
        
        // Добавление объекта к корневому вью
        self.view.addSubview(self.titleLabel)
        
        // Отключение автоматических ограничений
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50)
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        // MARK: Метка "Блюдо"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.nameTitleLabel = UILabel()
        
        // Создание метки
        createLabel(rootView: self.view,
                    label: self.nameTitleLabel,
                    text: "Блюдо",
                    fontWeight: .medium,
                    isCenterTextAlignment: true)
        
        // Добавление объекта к корневому вью
        self.view.addSubview(self.nameTitleLabel)
        
        // Отключение автоматических ограничений
        self.nameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Расстояние от базового элемента до левого края метки с названием блюда (для iPhone 14)
        let leftAnchorOfNameTitleLabel: CGFloat = 30
        
        // Ширина метки с названием блюда (для iPhone 14)
        let widthOfNameTitleLabel: CGFloat = 165
        
        // Расстояние от базового элемента до верхнего края метки с названием блюда (для iPhone 14)
        let topAnchorOfNameTitleLabel: CGFloat = 20
        
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
        createLabel(rootView: self.view,
                    label: self.priceTitleLabel,
                    text: "Цена",
                    fontWeight: .medium,
                    isCenterTextAlignment: true)
        
        // Добавление объекта к корневому вью
        self.view.addSubview(self.priceTitleLabel)
        
        // Отключение автоматических ограничений
        self.priceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Расстояние от базового элемента до левого края метки с ценой блюда (для iPhone 14)
        let leftAnchorOfPriceTitleLabel: CGFloat = 10
        
        // Ширина метки с ценой блюда (для iPhone 14)
        let widthOfPriceTitleLabel: CGFloat = 60
        
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
        createLabel(rootView: self.view,
                    label: self.countTitleLabel,
                    text: "Кол-во",
                    fontWeight: .medium,
                    isCenterTextAlignment: true)
        
        // Добавление объекта к корневому вью
        self.view.addSubview(self.countTitleLabel)
        
        // Отключение автоматических ограничений
        self.countTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Расстояние от базового элемента до левого края метки с ценой блюда (для iPhone 14)
        let leftAnchorOfCountTitleLabel: CGFloat = 10
        
        // Ширина метки с количеством (для iPhone 14)
        let widthOfCountTitleLabel: CGFloat = 80
        
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
        
        
        
        // MARK: Настройка графических элементов позиций чека
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        for food in self.order.order.keys {
            self.arrayOfBillPosition.append(food)
        }
        
        for i in 0..<self.arrayOfBillPosition.count {
            if i == 0 {
                createNewBillPosition(food: arrayOfBillPosition[i],
                                      baseElementForPositioning: self.nameTitleLabel.bottomAnchor,
                                      verticalDistanceFromBaseElement: (20 * heightOfRootView / iPhone14SceneHeight))
            } else {
                createNewBillPosition(food: arrayOfBillPosition[i],
                                      baseElementForPositioning:  dictionaryOfBillPosition[arrayOfBillPosition[i - 1]]!.nameLabel.bottomAnchor,
                                      verticalDistanceFromBaseElement: (20 * heightOfRootView / iPhone14SceneHeight))
            }
        }
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Метка "Итого"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.totalPriceLabel = UILabel()
        
        // Настройка метки
        createLabel(rootView: self.view,
                    label: self.totalPriceLabel,
                    text: "Итого: \(order.totalPrice) рублей",
                    fontWeight: .medium,
                    isCenterTextAlignment: false)
        
        // Добавление метки к корневому вью
        self.view.addSubview(self.totalPriceLabel)
        
        // Отключение автоматических ограничений
        self.totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.totalPriceLabel.leftAnchor.constraint(equalTo:
                                                        dictionaryOfBillPosition[self.arrayOfBillPosition.last!]!.nameLabel.leftAnchor),
            self.totalPriceLabel.topAnchor.constraint(equalTo:
                                                        dictionaryOfBillPosition[self.arrayOfBillPosition.last!]!.nameLabel.bottomAnchor,
                                                      constant: 20)
        ])
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка "background view"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        self.backgoundView = UIView()
        self.backgoundView.backgroundColor = .white
        self.backgoundView.layer.cornerRadius = (15 * widthOfRootView / iPhone14SceneWidth)
        
        self.view.addSubview(self.backgoundView)
        self.view.sendSubviewToBack(self.backgoundView)
        
        self.backgoundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.backgoundView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.backgoundView.topAnchor.constraint(equalTo: self.titleLabel.topAnchor,
                                                    constant: -(10 * heightOfRootView / iPhone14SceneHeight)),
            self.backgoundView.leftAnchor.constraint(equalTo: self.nameTitleLabel.leftAnchor,
                                                     constant: -(10 * widthOfRootView / iPhone14SceneWidth)),
            self.backgoundView.bottomAnchor.constraint(equalTo: self.totalPriceLabel.bottomAnchor,
                                                       constant: (10 * heightOfRootView / iPhone14SceneHeight))
        ])
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Кнопка "Подтвердить заказ"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация
        self.confirmButton = UIButton()
        
        // Настройка кнопки
        createButton(rootView: self.view, button: self.confirmButton, title: "Подтвердить заказ")
        
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
        self.confirmButton.addTarget(self, action: #selector(goToViewControllerOfCompletion), for: .touchUpInside)
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
    }
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
 
    
    
    // MARK: - Функция создания новой позиции в чеке
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    func createNewBillPosition(food: Food,
                           baseElementForPositioning: NSLayoutYAxisAnchor,
                           verticalDistanceFromBaseElement: CGFloat) {
        
        // MARK: Инициализация и первоначальная настройка графических элементов
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Метка с названием блюда
        let nameLabel = UILabel()
        createLabel(rootView: self.view,
                    label: nameLabel,
                    text: (food.name),
                    numberOfLines: 2,
                    fontWeight: .thin,
                    isCenterTextAlignment: true)
        
        // Метка со стоимостью блюда
        let priceLabel = UILabel()
        createLabel(rootView: self.view,
                    label: priceLabel,
                    text: "\(food.price)",
                    fontWeight: .thin,
                    isCenterTextAlignment: true)
        
        // Метка с количеством заказанного блюда
        let countLabel = UILabel()
        createLabel(rootView: self.view,
                    label: countLabel,
                    text: "\(self.order.order[food]!)",
                    fontWeight: .thin,
                    isCenterTextAlignment: true)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Добавление графических элементов к корневому вью
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.view.addSubview(nameLabel)
        self.view.addSubview(priceLabel)
        self.view.addSubview(countLabel)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Отключение автоматических ограничений
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Добавление графических элементов в словарь с позициями в чеке
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.dictionaryOfBillPosition[food] = (nameLabel: nameLabel,
                                               priceLabel: priceLabel,
                                               countLabel: countLabel)
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
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
    }
    
    
    
    // MARK: - Обработчик нажатия на кнопку "Подтвердить заказ"
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    @objc func goToViewControllerOfCompletion() {
        let objectOfMainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let vcOfCompletion = (objectOfMainStoryBoard.instantiateViewController(withIdentifier: "ViewControllerOfCompletion") as! ViewControllerOfCompletion)
        vcOfCompletion.closureForCompleteThisOrder = {
            self.navigationController?.popToRootViewController(animated: true)
        }
        self.present(vcOfCompletion, animated: true)
    }
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
}
