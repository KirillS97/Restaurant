import UIKit

class ViewControllerOfReservation: UIViewController {
    
    
    
    // MARK: - Хранимые свойства
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    // Пользователь
    var user: User?
    
    // Заказ
    var order: Order?
    
    // Экземпляр выбранного стола
    var chosenTable: Table?
    
    // Экземпляр вью контроллера "ViewControllerOfChoosingTable" сцены с выбором стола
    var vcOfChoosingTable: ViewControllerOfChoosingTable?
    
    // Экземпляр вью контроллера "ViewControllerOfMenu" сцены с созданием предзаказа
    var vcOfMenu: ViewControllerOfMenu?

    // Метки
    var nameLabel, guestNumberLabel, tableNumberLabel, preOrderLabel: UILabel!
    
    // Текстовые поля
    var nameTextField, guestNumberTextField, tableNumberTextField: UITextField!
    
    // Переключатель
    var preOrderSwitch: UISwitch!
    
    // Кнопка "Оформить заказ"
    var createOrderButton: UIButton!
    
    var labelNotice: UILabel!
    
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
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка метки "ФИО"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация
        self.nameLabel = UILabel()
        
        // Настройка метки
        createLabel(rootView: self.view, label: self.nameLabel, text: "ФИО:", numberOfLines: nil, fontSize: nil, fontWeight: .semibold, textColor: .systemRed, isCenterTextAlignment: false)
        
        // Добавление объекта на корневой вью
        self.view.addSubview(self.nameLabel)
        
        // Отключение автоматических ограничений
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.nameLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 50),
            self.nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: (heightOfRootView / 17))
        ])
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка текстового поля "ФИО"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация
        self.nameTextField = UITextField()
        
        // Настройка текстового поля
        createTextField(rootView: self.view, textfield: self.nameTextField, placeholder: "Введите Ваши ФИО", borderStyle: .roundedRect)
        
        // Настройка текста в текстовом поле
        if self.user != nil {
            self.nameTextField.text = "\(self.user!.firstName)" + " " + "\(self.user!.lastName)"
        }
        
        // Добавление текстового поля на родительский вью
        self.view.addSubview(self.nameTextField)
        
        // Отключение автоматических ограничений
        self.nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта текстового поля на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.nameTextField.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor),
            self.nameTextField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -50),
            self.nameTextField.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: (heightOfRootView / 85.2))
        ])
        
        // Добавление обработчика нажатия на текстовое поле
        // self.emailTextField.addTarget(self, action: #selector(removeTextOfLabelNotice), for: .touchDown)
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка метки "Количество гостей"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация
        self.guestNumberLabel = UILabel()
        
        // Настройка метки
        createLabel(rootView: self.view, label: self.guestNumberLabel, text: "Количество гостей:", numberOfLines: nil, fontSize: nil, fontWeight: .semibold, textColor: .systemRed, isCenterTextAlignment: false)
        
        // Добавление объекта на корневой вью
        self.view.addSubview(self.guestNumberLabel)
        
        // Отключение автоматических ограничений
        self.guestNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.guestNumberLabel.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor),
            self.guestNumberLabel.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: (heightOfRootView / 42.6))
        ])
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка текстового поля "Количество гостей"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация
        self.guestNumberTextField = UITextField()
        
        // Настройка текстового поля
        createTextField(rootView: self.view, textfield: self.guestNumberTextField, placeholder: "Не более 7 гостей", borderStyle: .roundedRect)
        
        // Добавление текстового поля на родительский вью
        self.view.addSubview(self.guestNumberTextField)
        
        // Отключение автоматических ограничений
        self.guestNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта текстового поля на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.guestNumberTextField.leftAnchor.constraint(equalTo: self.guestNumberLabel.leftAnchor),
            self.guestNumberTextField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -50),
            self.guestNumberTextField.topAnchor.constraint(equalTo: self.guestNumberLabel.bottomAnchor, constant: (heightOfRootView / 85.2))
        ])
        
        // Добавление обработчика нажатия на текстовое поле
        // self.emailTextField.addTarget(self, action: #selector(removeTextOfLabelNotice), for: .touchDown)
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка метки "Номер стола"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация
        self.tableNumberLabel = UILabel()
        
        // Настройка метки
        createLabel(rootView: self.view, label: self.tableNumberLabel, text: "Номер стола:", numberOfLines: nil, fontSize: nil, fontWeight: .semibold, textColor: .systemRed, isCenterTextAlignment: false)
        
        // Добавление объекта на корневой вью
        self.view.addSubview(self.tableNumberLabel)
        
        // Отключение автоматических ограничений
        self.tableNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.tableNumberLabel.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor),
            self.tableNumberLabel.topAnchor.constraint(equalTo: self.guestNumberTextField.bottomAnchor, constant: (heightOfRootView / 42.6))
        ])
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка текстового поля "Номер стола"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация
        self.tableNumberTextField = UITextField()
        
        // Настройка текстового поля
        createTextField(rootView: self.view, textfield: self.tableNumberTextField, placeholder: "Выберите свободный стол", borderStyle: .roundedRect)
        
        // Добавление текстового поля на родительский вью
        self.view.addSubview(self.tableNumberTextField)
        
        // Отключение автоматических ограничений
        self.tableNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта текстового поля на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.tableNumberTextField.leftAnchor.constraint(equalTo: self.tableNumberLabel.leftAnchor),
            self.tableNumberTextField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -50),
            self.tableNumberTextField.topAnchor.constraint(equalTo: self.tableNumberLabel.bottomAnchor, constant: (heightOfRootView / 85.2))
        ])
        
        // Добавление обработчика нажатия на текстовое поле
        // self.emailTextField.addTarget(self, action: #selector(removeTextOfLabelNotice), for: .touchDown)
        self.tableNumberTextField.addTarget(self, action: #selector(goToViewControllerOfChoosingTable), for: .touchDown)
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка метки "Предзаказ"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        self.preOrderLabel = UILabel()
        
        // Настройка метки
        createLabel(rootView: self.view, label: self.preOrderLabel, text: "Предзаказ:", numberOfLines: nil, fontSize: nil, fontWeight: .semibold, textColor: .systemRed, isCenterTextAlignment: false)
        
        // Добавление объекта на корневой вью
        self.view.addSubview(self.preOrderLabel)
        
        // Отключение автоматических ограничений
        self.preOrderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.preOrderLabel.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor),
            self.preOrderLabel.topAnchor.constraint(equalTo: self.tableNumberTextField.bottomAnchor, constant: (heightOfRootView / 42.6))
        ])
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка переключателя "Предзаказ"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.preOrderSwitch = UISwitch()
        
        // Настройка цвета
        self.preOrderSwitch.thumbTintColor = .white
        self.preOrderSwitch.onTintColor = .systemRed
        
        // Добавление переключателя к корневому вью
        self.view.addSubview(self.preOrderSwitch)
        
        // Отключение автоматических ограничений
        self.preOrderSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка ограничений
        NSLayoutConstraint.activate([
            self.preOrderSwitch.centerYAnchor.constraint(equalTo: self.preOrderLabel.centerYAnchor),
            self.preOrderSwitch.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -50)
        ])
        
        // Перевод переключателя в выключенный режим
        self.preOrderSwitch.isOn = false
        
        // Добавление обработчика изменения значения
        self.preOrderSwitch.addTarget(self, action: #selector(goToViewControllerOfMenu), for: .valueChanged)
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка кнопки "Оформить заказ"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.createOrderButton = UIButton()
        
        // Настройка объекта
        createButton(rootView: self.view, button: self.createOrderButton, title: "Оформить заказ")
        
        // Добавление объекта к корневому вью
        self.view.addSubview(self.createOrderButton)
        
        // Отключение автоматических ограничений
        self.createOrderButton.translatesAutoresizingMaskIntoConstraints = false

        // Установка ограничений
        NSLayoutConstraint.activate([
            self.createOrderButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.createOrderButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor,
                                                         constant: (50 * widthOfRootView / iPhone14SceneWidth)),
            self.createOrderButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                                           constant: -(100 * heightOfRootView) / iPhone14SceneHeight)
        ])
        
        // Добавление обработчика нажатия на кнопку
        self.createOrderButton.addTarget(self, action: #selector(goToViewControllerOfBill), for: .touchUpInside)
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка метки с уведомлением
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.labelNotice = UILabel()
        
        // Настройка внешнего вида метки
        createLabel(rootView: self.view, label: self.labelNotice, text: "", numberOfLines: 2, fontSize: nil, fontWeight: .light, textColor: .systemRed, isCenterTextAlignment: true)
        
        // Добавление метки на родительский вью
        self.view.addSubview(self.labelNotice)
        
        // Отключение автоматических ограничений
        self.labelNotice.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта метки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.labelNotice.leftAnchor.constraint(equalTo: self.createOrderButton.leftAnchor),
            self.labelNotice.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.labelNotice.bottomAnchor.constraint(equalTo: self.createOrderButton.topAnchor,
                                                  constant: -(20 * heightOfRootView / iPhone14SceneHeight)
                                                 )
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
    }
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: "viewWillAppar" method
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if vcOfMenu != nil {
            if self.order == nil {
                self.preOrderSwitch.setOn(false, animated: false)
            } else {
                self.preOrderSwitch.setOn(true, animated: false)
            }
        }
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - "prepare" method
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "goToVCOfChoosingTable" {
            if self.vcOfChoosingTable == nil {
                self.vcOfChoosingTable = (segue.destination as! ViewControllerOfChoosingTable)
                vcOfChoosingTable!.closureForTableTransfer = { table in
                    self.chosenTable = table
                    self.tableNumberTextField.text = String(table.numberOfTable)
                }
            }
        }
        if segue.identifier == "goToVCOfMenu" {
            if self.vcOfMenu == nil {
                self.vcOfMenu = (segue.destination as! ViewControllerOfMenu)
                self.vcOfMenu!.closureForOrderTransfer = { (order) in
                    self.order = order
                }
            }
        }
        if segue.identifier == "goToVCOfBill" {
            let vcOfBill = (segue.destination as! ViewControllerOfBill)
            vcOfBill.order = self.order!
        }
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик нажатия на текстовое поле "Номер стола" для перехода на сцену с выбором стола
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    @objc func goToViewControllerOfChoosingTable() {
        if self.vcOfChoosingTable == nil {
            performSegue(withIdentifier: "goToVCOfChoosingTable", sender: nil)
        } else {
            self.vcOfChoosingTable?.chosenTable = self.chosenTable
            navigationController?.pushViewController(self.vcOfChoosingTable!, animated: true)
        }
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик изменения значения в переключателе для предзаказа
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    @objc func goToViewControllerOfMenu() {
        if self.preOrderSwitch.isOn {
            if self.vcOfMenu == nil {
                performSegue(withIdentifier: "goToVCOfMenu", sender: nil)
            } else {
                if self.order == nil {
                    self.vcOfMenu!.order = Order()
                } else {
                    self.vcOfMenu!.order = self.order!
                }
                navigationController!.pushViewController(self.vcOfMenu!, animated: true)
            }
        }
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
 
    
    
    // MARK: - Обработчик нажатия на кнопку "Оформить заказ"
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    @objc func goToViewControllerOfBill() {
        
        if (self.nameTextField.text!.isEmpty) ||
            (self.guestNumberTextField.text!.isEmpty) ||
            (self.tableNumberTextField.text!.isEmpty)
        {
            self.labelNotice.text = "Заполните все поля"
            return
        }
        
        if Int(self.guestNumberTextField.text!) == nil {
            self.labelNotice.text = "Введено недопустимое число гостей"
            return
        }
        
        if let numberOfGuests = Int(self.guestNumberTextField.text!) {
            if !(1...7).contains(numberOfGuests) {
                self.labelNotice.text = "Введено недопустимое число гостей"
                return
            } else {
                if self.preOrderSwitch.isOn {
                    performSegue(withIdentifier: "goToVCOfBill", sender: nil)
                } else {
                    let objectOfMainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                    let vcOfCompletion = (objectOfMainStoryBoard.instantiateViewController(withIdentifier: "ViewControllerOfCompletion") as! ViewControllerOfCompletion)
                    vcOfCompletion.closureForCompleteThisOrder = {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    self.present(vcOfCompletion, animated: true)
                }
            }
        }
        

        
    }
        

    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
}

