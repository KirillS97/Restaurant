import UIKit



class ViewControllerOfCreatingAccount: UIViewController {
    
    
    
    // MARK: - Хранимые свойства
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    // Хранилище зарегестрированных пользователей
    var usersStorage: UsersStorageProtocol!
    
    // Библиотека зарегестрированных пользователей
    var registeredUsers: [String: User] = [:] {
        didSet {
            usersStorage.saveRegisteredUsers(registeredUsers: self.registeredUsers)
        }
    }
    
    // Делегат для передачи ему данных с новыми пользователями
    var delegateToTranferRegisteredUsers: UpdateUsersStorageDelegate!
    
    // Метки
    var firstNameLabel, lastNameLabel, emailLabel, passwordLabel, confirmPasswordLabel, noticeLabel: UILabel!
    
    // Тектовые поля
    var firstNameTF, lastNameTF, emailTF, passwordTF, confirmPasswordTF: UITextField!
    
    // Кнопка "Создать аккаунт"
    var createAccountButton: UIButton!
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - viewDidLoad
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // MARK: Настройка главного "View"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.view.backgroundColor = viewColor
        
        let widthOfRootView = self.view.frame.width
        let heightOfRootView = self.view.frame.height
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка метки "Имя"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Инициализация объекта
        self.firstNameLabel = UILabel()
        
        // Настройка внешнего вида метки
        createLabel(rootView: self.view,
                    label: self.firstNameLabel,
                    text: "Имя:",
                    numberOfLines: nil,
                    fontSize: nil,
                    fontWeight: .semibold,
                    textColor: .systemRed,
                    isCenterTextAlignment: false)
        
        // Добавление метки на родительский вью
        self.view.addSubview(self.firstNameLabel)
        
        // Отключение автоматических ограничений
        self.firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта метки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.firstNameLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor,
                                                      constant: (50 * heightOfRootView / iPhone14SceneHeight)),
            self.firstNameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                                 constant: (50 * heightOfRootView / iPhone14SceneHeight))
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка текстового поля "Имя"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Инициализация
        self.firstNameTF = UITextField()
        
        // Настройка текстового поля
        createTextField(rootView: self.view,
                        textfield: self.firstNameTF,
                        placeholder: "Алексей",
                        borderStyle: .roundedRect)
        
        // Добавление текстового поля на родительский вью
        self.view.addSubview(self.firstNameTF)
        
        // Отключение автоматических ограничений
        self.firstNameTF.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта текстового поля на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.firstNameTF.leftAnchor.constraint(equalTo: self.firstNameLabel.leftAnchor),
            self.firstNameTF.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,
                                                       constant: -(50 * widthOfRootView / iPhone14SceneWidth)),
            self.firstNameTF.topAnchor.constraint(equalTo: self.firstNameLabel.bottomAnchor,
                                                     constant: (10 * heightOfRootView / iPhone14SceneHeight))
        ])
        
        // Добавление обработчика нажатия на текстовое поле
        self.firstNameTF.addTarget(self, action: #selector(clearNoticeLabel), for: .touchDown)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка метки "Фамилия"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Инициализация объекта
        self.lastNameLabel = UILabel()
        
        // Настройка внешнего вида метки
        createLabel(rootView: self.view,
                    label: self.lastNameLabel,
                    text: "Фамилия:",
                    numberOfLines: nil,
                    fontSize: nil,
                    fontWeight: .semibold,
                    textColor: .systemRed,
                    isCenterTextAlignment: false)
        
        // Добавление метки на родительский вью
        self.view.addSubview(self.lastNameLabel)
        
        // Отключение автоматических ограничений
        self.lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта метки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.lastNameLabel.leftAnchor.constraint(equalTo: self.firstNameLabel.leftAnchor),
            self.lastNameLabel.topAnchor.constraint(equalTo: self.firstNameTF.bottomAnchor,
                                                    constant: (10 * heightOfRootView / iPhone14SceneHeight))
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка текстового поля "Фамилия"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Инициализация
        self.lastNameTF = UITextField()
        
        // Настройка текстового поля
        createTextField(rootView: self.view,
                        textfield: self.lastNameTF,
                        placeholder: "Алексеев",
                        borderStyle: .roundedRect)
        
        // Добавление текстового поля на родительский вью
        self.view.addSubview(self.lastNameTF)
        
        // Отключение автоматических ограничений
        self.lastNameTF.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта текстового поля на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.lastNameTF.leftAnchor.constraint(equalTo: self.lastNameLabel.leftAnchor),
            self.lastNameTF.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,
                                                   constant: -(50 * widthOfRootView / iPhone14SceneWidth)),
            self.lastNameTF.topAnchor.constraint(equalTo: self.lastNameLabel.bottomAnchor,
                                                 constant: (10 * heightOfRootView / iPhone14SceneHeight))
        ])
        
        // Добавление обработчика нажатия на текстовое поле
        self.lastNameTF.addTarget(self, action: #selector(clearNoticeLabel), for: .touchDown)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка метки "Email"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Инициализация объекта
        self.emailLabel = UILabel()
        
        // Настройка внешнего вида метки
        createLabel(rootView: self.view,
                    label: self.emailLabel,
                    text: "Email:",
                    numberOfLines: nil,
                    fontSize: nil,
                    fontWeight: .semibold,
                    textColor: .systemRed,
                    isCenterTextAlignment: false)
        
        // Добавление метки на родительский вью
        self.view.addSubview(self.emailLabel)
        
        // Отключение автоматических ограничений
        self.emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта метки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.emailLabel.leftAnchor.constraint(equalTo: self.lastNameLabel.leftAnchor),
            self.emailLabel.topAnchor.constraint(equalTo: self.lastNameTF.bottomAnchor,
                                                 constant: (10 * heightOfRootView / iPhone14SceneHeight))
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка текстового поля "Email"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Инициализация
        self.emailTF = UITextField()
        
        // Настройка текстового поля
        createTextField(rootView: self.view,
                        textfield: self.emailTF,
                        placeholder: "AlexAlekseev@mail.com",
                        borderStyle: .roundedRect)
        
        // Добавление текстового поля на родительский вью
        self.view.addSubview(self.emailTF)
        
        // Отключение автоматических ограничений
        self.emailTF.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта текстового поля на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.emailTF.leftAnchor.constraint(equalTo: self.emailLabel.leftAnchor),
            self.emailTF.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,
                                                constant: -(50 * widthOfRootView / iPhone14SceneWidth)),
            self.emailTF.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor,
                                              constant: (10 * heightOfRootView / iPhone14SceneHeight))
        ])
        
        // Добавление обработчика нажатия на текстовое поле
        self.emailTF.addTarget(self, action: #selector(clearNoticeLabel), for: .touchDown)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка метки "Пароль"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Инициализация объекта
        self.passwordLabel = UILabel()
        
        // Настройка внешнего вида метки
        createLabel(rootView: self.view,
                    label: self.passwordLabel,
                    text: "Пароль:",
                    numberOfLines: nil,
                    fontSize: nil,
                    fontWeight: .semibold,
                    textColor: .systemRed,
                    isCenterTextAlignment: false)
        
        // Добавление метки на родительский вью
        self.view.addSubview(self.passwordLabel)
        
        // Отключение автоматических ограничений
        self.passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта метки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.passwordLabel.leftAnchor.constraint(equalTo: self.emailLabel.leftAnchor),
            self.passwordLabel.topAnchor.constraint(equalTo: self.emailTF.bottomAnchor,
                                                    constant: (10 * heightOfRootView / iPhone14SceneHeight))
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка текстового поля "Пароль"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Инициализация
        self.passwordTF = UITextField()
        
        // Настройка текстового поля
        createTextField(rootView: self.view,
                        textfield: self.passwordTF,
                        placeholder: "qwerty",
                        borderStyle: .roundedRect)
        
        // Добавление текстового поля на родительский вью
        self.view.addSubview(self.passwordTF)
        
        // Отключение автоматических ограничений
        self.passwordTF.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта текстового поля на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.passwordTF.leftAnchor.constraint(equalTo: self.passwordLabel.leftAnchor),
            self.passwordTF.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,
                                                   constant: -(50 * widthOfRootView / iPhone14SceneWidth)),
            self.passwordTF.topAnchor.constraint(equalTo: self.passwordLabel.bottomAnchor,
                                                 constant: (10 * heightOfRootView / iPhone14SceneHeight))
        ])
        
        // Добавление обработчика нажатия на текстовое поле
        self.passwordTF.addTarget(self, action: #selector(clearNoticeLabel), for: .touchDown)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка метки "Подтвердите пароль"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Инициализация объекта
        self.confirmPasswordLabel = UILabel()
        
        // Настройка внешнего вида метки
        createLabel(rootView: self.view,
                    label: self.confirmPasswordLabel,
                    text: "Подтвердите пароль:",
                    numberOfLines: nil,
                    fontSize: nil,
                    fontWeight: .semibold,
                    textColor: .systemRed,
                    isCenterTextAlignment: false)
        
        // Добавление метки на родительский вью
        self.view.addSubview(self.confirmPasswordLabel)
        
        // Отключение автоматических ограничений
        self.confirmPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта метки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.confirmPasswordLabel.leftAnchor.constraint(equalTo: self.passwordLabel.leftAnchor),
            self.confirmPasswordLabel.topAnchor.constraint(equalTo: self.passwordTF.bottomAnchor,
                                                           constant: (10 * heightOfRootView / iPhone14SceneHeight))
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка текстового поля "Подтвердите пароль"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Инициализация
        self.confirmPasswordTF = UITextField()
        
        // Настройка текстового поля
        createTextField(rootView: self.view,
                        textfield: self.confirmPasswordTF,
                        placeholder: "qwerty",
                        borderStyle: .roundedRect)
        
        // Добавление текстового поля на родительский вью
        self.view.addSubview(self.confirmPasswordTF)
        
        // Отключение автоматических ограничений
        self.confirmPasswordTF.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта текстового поля на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.confirmPasswordTF.leftAnchor.constraint(equalTo: self.confirmPasswordLabel.leftAnchor),
            self.confirmPasswordTF.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,
                                                          constant: -(50 * widthOfRootView / iPhone14SceneWidth)),
            self.confirmPasswordTF.topAnchor.constraint(equalTo: self.confirmPasswordLabel.bottomAnchor,
                                                        constant: (10 * heightOfRootView / iPhone14SceneHeight))
        ])
        
        // Добавление обработчика нажатия на текстовое поле
        self.confirmPasswordTF.addTarget(self, action: #selector(clearNoticeLabel), for: .touchDown)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка метки с уведомлением
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Инициализация объекта
        self.noticeLabel = UILabel()
        
        // Настройка внешнего вида метки
        createLabel(rootView: self.view,
                    label: self.noticeLabel,
                    text: "",
                    numberOfLines: 2,
                    fontSize: nil,
                    fontWeight: .light,
                    textColor: .systemRed,
                    isCenterTextAlignment: true)
        
        // Добавление метки на родительский вью
        self.view.addSubview(self.noticeLabel)
        
        // Отключение автоматических ограничений
        self.noticeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта метки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.noticeLabel.leftAnchor.constraint(equalTo: self.confirmPasswordLabel.leftAnchor),
            self.noticeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.noticeLabel.topAnchor.constraint(equalTo: self.confirmPasswordTF.bottomAnchor,
                                                  constant: (10 * heightOfRootView / iPhone14SceneHeight))
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка кнопки "Создать аккаут"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Инициализация объекта
        self.createAccountButton = UIButton()
        
        // Настройка внешнего вида кнопки
        createButton(rootView: self.view, button: self.createAccountButton, title: "Создать аккаунт")
        
        // Добавление кнопки на родительский вью
        self.view.addSubview(self.createAccountButton)
        
        // Отключение автоматических ограничений
        self.createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта кнопки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.createAccountButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.createAccountButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor,
                                                           constant: (50 * widthOfRootView / iPhone14SceneWidth)),
            self.createAccountButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                                             constant: -(100 * heightOfRootView / iPhone14SceneHeight))
        ])
        
        // Добавление обработчика нажатия на кнопку
        self.createAccountButton.addTarget(self, action: #selector(createAccount(sener:)), for: .touchUpInside)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        
        
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - viewWillDisappear
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    @objc func createAccount(sener: UIButton) -> Void {
        guard sener.isEqual(self.createAccountButton) else { return }
        let firstName        : String = self.firstNameTF.text ?? ""
        let lastName         : String = self.lastNameTF.text ?? ""
        let email            : String = self.emailTF.text ?? ""
        let password         : String = self.passwordTF.text ?? ""
        let confirmedPassword: String = self.confirmPasswordTF.text ?? ""
        let textFieldsValues = (firstName, lastName, email, password, confirmedPassword)
        
        switch textFieldsValues {
        case let (_, _, email, _, _) where self.registeredUsers.contains(where: { (emailOfUser: String, value: User) in
            emailOfUser == email
        }):
            self.noticeLabel.text = "Пользователь с таким email уже существует"
            
            
        case let (firstName, lastName, email, password, confirmedPassword)
        where (firstName.isEmpty) || (lastName.isEmpty) || (email.isEmpty) || (password.isEmpty) || (confirmedPassword.isEmpty):
            self.noticeLabel.text = "Заполните все поля"
            
            
        case let (_, _, email, _, _) where !email.contains(where: { character in
            character == Character("@")
        }):
            self.noticeLabel.text = "Email должен содержать адрес электронной почты"
            
            
        case let (_, _, _, password, confirmedPassword) where password != confirmedPassword:
            self.noticeLabel.text = "Введённые пароли не совпадают"
            
            
        default:
            registerUser(firstName: firstName,
                         lastName: lastName,
                         email: email,
                         password: password,
                         users: &self.registeredUsers)
            self.delegateToTranferRegisteredUsers.updateUseresStorage(users: self.registeredUsers)
            if let navigationController {
                navigationController.popViewController(animated: true)
            }
        }
        
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    
    
    // MARK: - Обработчик нажатия для удаления текста уведомительной метки
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    @objc func clearNoticeLabel() {
        self.noticeLabel.text = ""
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
}
