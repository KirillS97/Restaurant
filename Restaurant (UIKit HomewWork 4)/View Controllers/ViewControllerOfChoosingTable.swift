import UIKit

class ViewControllerOfChoosingTable: UIViewController {
    
    
    
    // MARK: - Хранимые свойства
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    // План ресторана
    var restarauntPlan: UIImageView!
    
    // Кнопки выбора столов
    var tableButton1, tableButton2, tableButton3, tableButton4, tableButton5, tableButton6, tableButton7, tableButton8, tableButton9: UIButton!
    
    // Массив кнопок выбора столов
    var tableButtons: [UIButton] = []
    
    // Экземпляры столов
    var table1, table2, table3, table4, table5, table6, table7, table8, table9: Table!
    
    // Словарь столов и кнопок их выбора
    var tableDictionary: [Table: UIButton] = [:]
    
    // Экземпляр выбранного стола
    var chosenTable: Table?
    
    // Кнопка подтверждения
    var confirmButton: UIButton!
    
    // Метка с оповещением
    var noticeLabel: UILabel!
    
    // Замыкание для передачи выбранного стола в предыдущий вью контроллер
    var closureForTableTransfer: ((Table) -> Void)?
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - "viewDidLoad" method
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // MARK: Размеры корневого вью
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        let widthOfView = self.view.frame.width
        let heightOfView = self.view.frame.height
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка корневогого "View"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.view.backgroundColor = UIColor.systemGray5
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка изображения плана ресторана
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.restarauntPlan = UIImageView(image: UIImage(named: "planWithRemovedBackground.png"))
        
        // Добавление изображения к корневому вью
        self.view.addSubview(self.restarauntPlan)
        
        // Отключение автоматических ограничений
        self.restarauntPlan.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта изображения на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.restarauntPlan.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.restarauntPlan.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.restarauntPlan.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            self.restarauntPlan.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 1)
        ])
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Первоначальная настройка кнопок выбора столов
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация кнопок выбора
        self.tableButton1 = UIButton()
        self.tableButton2 = UIButton()
        self.tableButton3 = UIButton()
        self.tableButton4 = UIButton()
        self.tableButton5 = UIButton()
        self.tableButton6 = UIButton()
        self.tableButton7 = UIButton()
        self.tableButton8 = UIButton()
        self.tableButton9 = UIButton()
        
        // Инициализация массива кнопок выбора
        self.tableButtons = [self.tableButton1,
                             self.tableButton2,
                             self.tableButton3,
                             self.tableButton4,
                             self.tableButton5,
                             self.tableButton6,
                             self.tableButton7,
                             self.tableButton8,
                             self.tableButton9
        ]
        
        // Общая настройка кнопок
        for button in tableButtons {

            // Локальные константы для настройки
            let borderWidth: CGFloat = pow(( pow(widthOfView, 2) + pow(heightOfView, 2) ), 1/2) * 0.005
            let cornerRadius = CGFloat(5)

            // Настройка внешнего вида кнопки
            button.layer.borderWidth = borderWidth
            button.layer.cornerRadius = cornerRadius

            // Добавление кнопки на родительский вью
            self.view.addSubview(button)

            // Отключение автоматических ограничений
            button.translatesAutoresizingMaskIntoConstraints = false
            
            // Добавление обработчика нажатия на кнопку выбора стола
            button.addTarget(self, action: #selector(chooseTheTable(sender:)), for: .touchUpInside)
        }
        
        // Установка ограничений для кнопок производится в методе "viewDidLayoutSubviews", а не в методе "viewDidLoad" т.к. в данном случае необходимо позиционировать кнопки относительно изображения плана ресторана или относительно безопасной области (safe area), но сама safe area настраивается только в методе "viewDidLayoutSubviews" (в том числе и её размер). При установке ограничений для кнопок в методе "viewDidLoad" даже с использованием коэффициентов размеров элементов, результат будет отличен от устройства к устройству.
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка экземпляров столов
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объектов
        self.table1 = Table(numberOfTable: 1)
        self.table2 = Table(numberOfTable: 2)
        self.table3 = Table(numberOfTable: 3)
        self.table4 = Table(numberOfTable: 4)
        self.table5 = Table(numberOfTable: 5)
        self.table6 = Table(numberOfTable: 6)
        self.table7 = Table(numberOfTable: 7)
        self.table8 = Table(numberOfTable: 8)
        self.table9 = Table(numberOfTable: 9)
        
        // Инициализация словаря столов
        self.tableDictionary = [table1: tableButton1,
                                table2: tableButton2,
                                table3: tableButton3,
                                table4: tableButton4,
                                table5: tableButton5,
                                table6: tableButton6,
                                table7: tableButton7,
                                table8: tableButton8,
                                table9: tableButton9
        ]
        
        for (table, _) in tableDictionary {
            table.isFree = Bool.random()
        }
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка кнопки "Подтвердить"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.confirmButton = UIButton()
        
        // Настройка кнопки
        createButton(rootView: self.view, button: self.confirmButton, title: "Выбрать", fontSize: nil, fontWeight: .semibold, normalTitleColor: nil, highlightedTitleColor: nil, backgroundColor: nil, cornerRadius: nil, height: nil)
        
        // Добавление кнопки на родительский вью
        self.view.addSubview(self.confirmButton)
        
        // Отключение автоматических ограничений
        self.confirmButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавление обработчика нажатия на кнопку
        self.confirmButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка уведомительной метки
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.noticeLabel = UILabel()
        
        // Настройка метки
        createLabel(rootView: self.view, label: self.noticeLabel, text: "", numberOfLines: 3, isCenterTextAlignment: true)
        
        // Добавление метки к корневому вью
        self.view.addSubview(self.noticeLabel)
        
        // Отключение автоматических ограничений
        self.noticeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
    }
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - "viewWillAppear" method
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: Настройка цвета кнопок выбора
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        for (table, tableButton) in tableDictionary {
            if (table.isChoosen) && (table.numberOfTable != self.chosenTable?.numberOfTable) {
                table.vacateTheTable()
            }
            if (self.chosenTable != nil) && (table.numberOfTable == self.chosenTable!.numberOfTable) {
                table.chooseTheTable()
            }
            changeTheButtonColor(tableButton: tableButton, table: table)
        }
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка текста уведомительной метки
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        if self.chosenTable != nil {
            self.noticeLabel.text = "Забронировать стол №\(self.chosenTable!.numberOfTable)?"
            self.noticeLabel.textColor = .black
        } else { self.noticeLabel.text = "" }
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
    }
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - "viewDidLayoutSubviews" method
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // MARK: Размеры изображения с планом ресторна
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        let widthOfRestarauntPlan = self.restarauntPlan.frame.width
        let heightOfRestarauntPlan = self.restarauntPlan.frame.height
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */



        // MARK: Коэффициенты размера стола на 5 персон
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // (Коэффициенты подобраны опытным путём)
        let smallTableWidthFactor: CGFloat = (0.11) // Коэф. ширины стола
        let smallTableHightFactor: CGFloat = (0.038) // Коэф. высоты стола
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */



        // MARK: Позиционирование кнопки выбора стола №1 (стол на 5 персон)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // (Коэффициенты подобраны опытным путём)
        buttonPositioning(tableButton: self.tableButton1, topDistanceFactor: 0.37, leftDistanceFactor: 0.52, widthFactor: smallTableWidthFactor, heightFactor: smallTableHightFactor)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */



        // MARK: Позиционирование кнопки выбора стола №2 (стол на 5 персон)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // (Коэффициенты подобраны опытным путём)
        buttonPositioning(tableButton: self.tableButton2, topDistanceFactor: 0.46, leftDistanceFactor: 0.52, widthFactor: smallTableWidthFactor, heightFactor: smallTableHightFactor)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */



        // MARK: Позиционирование кнопки выбора стола №3 (стол на 5 персон)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // (Коэффициенты подобраны опытным путём)
        buttonPositioning(tableButton: self.tableButton3, topDistanceFactor: 0.595, leftDistanceFactor: 0.535, widthFactor: smallTableWidthFactor, heightFactor: smallTableHightFactor)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */



        // MARK: Позиционирование кнопки выбора стола №4 (стол на 5 персон)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // (Коэффициенты подобраны опытным путём)
        buttonPositioning(tableButton: self.tableButton4, topDistanceFactor: 0.705, leftDistanceFactor: 0.535, widthFactor: smallTableWidthFactor, heightFactor: smallTableHightFactor)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */



        // MARK: Позиционирование кнопки выбора стола №5 (стол на 5 персон)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // (Коэффициенты подобраны опытным путём)
        buttonPositioning(tableButton: self.tableButton5, topDistanceFactor: 0.815, leftDistanceFactor: 0.535, widthFactor: smallTableWidthFactor, heightFactor: smallTableHightFactor)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Коэффициенты размера стола на 7 персон
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // (Коэффициенты подобраны опытным путём)
        let bigTableWidthFactor: CGFloat = (0.15) // Коэф. ширины стола
        let bigTableHightFactor: CGFloat = (0.04) // Коэф. высоты стола
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Позиционирование кнопки выбора стола №6 (стол на 7 персон)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // (Коэффициенты подобраны опытным путём)
        buttonPositioning(tableButton: self.tableButton6, topDistanceFactor: 0.665, leftDistanceFactor: 0.81, widthFactor: bigTableWidthFactor, heightFactor: bigTableHightFactor)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Позиционирование кнопки выбора стола №7 (стол на 7 персон)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // (Коэффициенты подобраны опытным путём)
        buttonPositioning(tableButton: self.tableButton7, topDistanceFactor: 0.545, leftDistanceFactor: 0.81, widthFactor: bigTableWidthFactor, heightFactor: bigTableHightFactor)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Позиционирование кнопки выбора стола №8 (стол на 7 персон)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // (Коэффициенты подобраны опытным путём)
        buttonPositioning(tableButton: self.tableButton8, topDistanceFactor: 0.42, leftDistanceFactor: 0.81, widthFactor: bigTableWidthFactor, heightFactor: bigTableHightFactor)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Позиционирование кнопки выбора стола №9 (стол на 7 персон)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // (Коэффициенты подобраны опытным путём)
        buttonPositioning(tableButton: self.tableButton9, topDistanceFactor: 0.3, leftDistanceFactor: 0.81, widthFactor: bigTableWidthFactor, heightFactor: bigTableHightFactor)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Функция позиционирования кнопки выбора стола
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        func buttonPositioning(tableButton: UIButton,
                               topDistanceFactor: CGFloat,
                               leftDistanceFactor: CGFloat,
                               widthFactor: CGFloat,
                               heightFactor: CGFloat) {
            
            NSLayoutConstraint.activate([
                tableButton.topAnchor.constraint(equalTo: self.restarauntPlan.topAnchor, constant: (topDistanceFactor * heightOfRestarauntPlan)),
                tableButton.leftAnchor.constraint(equalTo: self.restarauntPlan.leftAnchor, constant: (leftDistanceFactor * widthOfRestarauntPlan)),
                tableButton.widthAnchor.constraint(equalToConstant: (widthFactor * widthOfRestarauntPlan)),
                tableButton.heightAnchor.constraint(equalToConstant: (heightFactor * heightOfRestarauntPlan))
            ])
        }
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Позиционирование кнопки "Подтвердить"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // (Коэффициенты подобраны опытным путём)
        NSLayoutConstraint.activate([
            self.confirmButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 15),
            self.confirmButton.widthAnchor.constraint(equalTo: self.restarauntPlan.widthAnchor, multiplier: 0.41),
            self.confirmButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -(0.138 * heightOfRestarauntPlan))
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Позиционирование уведомительной метки
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // (Коэффициенты подобраны опытным путём)
        NSLayoutConstraint.activate([
            self.noticeLabel.leftAnchor.constraint(equalTo: self.confirmButton.leftAnchor),
            self.noticeLabel.widthAnchor.constraint(equalTo: self.confirmButton.widthAnchor),
            self.noticeLabel.bottomAnchor.constraint(equalTo: self.confirmButton.topAnchor, constant: -(0.025 * heightOfRestarauntPlan))
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
    }
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Функция изменения цвета кнопки
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    func changeTheButtonColor(tableButton: UIButton, table: Table) -> Void {
        if table.isFree { tableButton.layer.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1) }
        if table.isReserved { tableButton.layer.borderColor = .init(red: 1, green: 0, blue: 0, alpha: 1) }
        if table.isChoosen { tableButton.layer.borderColor = .init(red: 0, green: 1, blue: 0, alpha: 1) }
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    

    
    // MARK: - Обработчик нажатия на кнопку выбора стола
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    @objc func chooseTheTable(sender: UIButton) -> Void {
        for (table, tableButton) in tableDictionary {
            if tableButton === sender {
                table.chooseTheTable()
                if table.isChoosen {
                    self.chosenTable = table
                    self.noticeLabel.text = "Забронировать стол №\(table.numberOfTable)?"
                    self.noticeLabel.textColor = .black
                } else {
                    self.chosenTable = nil
                    self.noticeLabel.text = "Стол №\(table.numberOfTable) уже занят"
                    self.noticeLabel.textColor = .systemRed
                }
            } else {
                if table.isChoosen {
                    table.vacateTheTable()
                }
            }
            changeTheButtonColor(tableButton: tableButton, table: table)
        }
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик нажатия на кнопку "Подтвердить"
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    @objc func confirm() {
        if let chosenTable {
            closureForTableTransfer!(chosenTable)
            self.navigationController?.popViewController(animated: true)
        } else {
            self.noticeLabel.text = "Выберите свободный стол"
            self.noticeLabel.textColor = .systemRed
        }
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
}
