import UIKit

class ViewControllerOfRegistartion: UIViewController {
    
    // MARK: - Хранимые свойства
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    //Изображение вверху сцены с логотоипом ресторана
    var imageForLogo: UIImage!
    var logo: UIImageView!
    
    // Метки с текстом
    var labelSignIn, labelEmail, labelPassword, labelNotice, enterAsAGuestLabel: UILabel!
    
    // Текстовые поля
    var emailTextField, passwordTextField: UITextField!
    
    // Кнопка "Войти"
    var buttonEnter: UIButton!
    
    // Кнопка "Создать аккаунт"
    var registrationButton: UIButton!
    
    // Переключатель "Продолжить, как гость"
    var guestSwitch: UISwitch!
    
    // Кнопка с глазом для сокрытия пароля в текстовом поле
    var buttonForHidePassword: UIButton!
    
    // Хранилище зарегестрированных пользователей
    var usersStorage: UsersStorageProtocol!
    
    //Библиотека зарегестрированных пользователей
    var registeredUsers: [String: User] = [:] {
        didSet {
            usersStorage.saveRegisteredUsers(registeredUsers: self.registeredUsers)
        }
    }
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    // MARK: - "viewDidLoad" method
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Добавление нового пользователя
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.usersStorage = UsersStorage()
        
        registerUser(firstName: "Kirill",
                     lastName: "Serov",
                     email: "123",
                     password: "123",
                     users: &self.registeredUsers)
        
        self.registeredUsers = self.usersStorage.loadRegisteredUsers()
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка корневогого "View"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.view.backgroundColor = viewColor
        
        let widthOfRootView = self.view.frame.width
        let heightOfRootView = self.view.frame.height
        let diagonalOfRootView = pow(( pow(widthOfRootView, 2) + pow(heightOfRootView, 2) ), 1/2)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка изображения вверху сцены
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объектов
        self.imageForLogo = UIImage(named: "Icon.png")?.scaleImage(targetWidth: (widthOfRootView / 2.5), targetHeight: nil)
        self.logo = UIImageView()
        
        // Добавление к объекту изображения
        self.logo.image = imageForLogo
        
        // Добавление объекта изображения к корневому "View"
        self.view.addSubview(self.logo)
        
        // Отключение системных ограничений
        self.logo.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта изображения на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.logo.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.logo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                           constant: (0 * heightOfRootView / iPhone14SceneHeight))
        ])
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка кнопки "Войти"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.buttonEnter = UIButton()
        
        // Настройка внешнего вида кнопки
        createButton(rootView: self.view, button: self.buttonEnter, title: "Войти")
        
        // Добавление кнопки на родительский вью
        self.view.addSubview(self.buttonEnter)
        
        // Отключение автоматических ограничений
        self.buttonEnter.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта кнопки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.buttonEnter.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,
                                                   constant: -(50 * widthOfRootView / iPhone14SceneWidth)),
            self.buttonEnter.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.buttonEnter.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                                     constant: -(80 * heightOfRootView / iPhone14SceneHeight))
        ])
        
        // Добавление обработчика нажатия на кнопку
        self.buttonEnter.addTarget(self, action: #selector(tryEnter(sender:)), for: .touchUpInside)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка кнопки "Создать аккаут"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.registrationButton = UIButton()
        
        // Настройка внешнего вида кнопки
        createButton(rootView: self.view, button: self.registrationButton, title: "Создать аккаунт")
        
        // Добавление кнопки на родительский вью
        self.view.addSubview(self.registrationButton)
        
        // Отключение автоматических ограничений
        self.registrationButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта кнопки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.registrationButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.registrationButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor,
                                                   constant: (50 * widthOfRootView / iPhone14SceneWidth)),
            self.registrationButton.bottomAnchor.constraint(equalTo: self.buttonEnter.topAnchor,
                                                     constant: -(20 * heightOfRootView / iPhone14SceneHeight))
        ])
        
        // Добавление обработчика нажатия на кнопку
        self.registrationButton.addTarget(self, action: #selector(registrationButtonHandler(sender:)), for: .touchUpInside)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка метки "Sign In"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.labelSignIn = UILabel()
        
        // Настройка внешнего вида метки
        createLabel(rootView: self.view, label: self.labelSignIn, text: "Sign In", numberOfLines: nil, fontSize: (heightOfRootView * labelTitleFontSizeFactor), fontWeight: .semibold, textColor: nil, isCenterTextAlignment: false)
        
        // Добавление метки на родительский вью
        self.view.addSubview(self.labelSignIn)
        
        // Отключение автоматических ограничений
        self.labelSignIn.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта метки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.labelSignIn.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor,
                                                   constant: (50 * widthOfRootView / iPhone14SceneWidth)
                                                  ),
            self.labelSignIn.topAnchor.constraint(equalTo: self.logo.bottomAnchor, constant:
                                                    (30 * heightOfRootView / iPhone14SceneHeight)
                                                 )
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка метки "Email"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация объекта
        self.labelEmail = UILabel()
        
        // Настройка внешнего вида метки
        createLabel(rootView: self.view, label: self.labelEmail, text: "Email:", numberOfLines: nil, fontSize: nil, fontWeight: .semibold, textColor: .systemRed, isCenterTextAlignment: false)
        
        // Добавление метки на родительский вью
        self.view.addSubview(self.labelEmail)
        
        // Отключение автоматических ограничений
        self.labelEmail.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта метки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.labelEmail.leftAnchor.constraint(equalTo: self.labelSignIn.leftAnchor),
            self.labelEmail.topAnchor.constraint(equalTo: self.labelSignIn.bottomAnchor,
                                                 constant: (30 * heightOfRootView / iPhone14SceneHeight)
                                                )
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка текстового поля "Email"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация
        self.emailTextField = UITextField()
        
        // Настройка текстового поля
        createTextField(rootView: self.view, textfield: self.emailTextField, placeholder: "Введите Email", borderStyle: .roundedRect)
        
        // Добавление текстового поля на родительский вью
        self.view.addSubview(self.emailTextField)
        
        // Отключение автоматических ограничений
        self.emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта текстового поля на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.emailTextField.leftAnchor.constraint(equalTo: self.labelEmail.leftAnchor),
            self.emailTextField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,
                                                       constant: -(50 * widthOfRootView / iPhone14SceneWidth)),
            self.emailTextField.topAnchor.constraint(equalTo: self.labelEmail.bottomAnchor,
                                                     constant: (10 * heightOfRootView / iPhone14SceneHeight))
        ])
        
        // Добавление обработчика нажатия на текстовое поле
        self.emailTextField.addTarget(self, action: #selector(removeTextOfLabelNotice), for: .touchDown)
        
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка метки "Пароль"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Инициализация объекта
        self.labelPassword = UILabel()
        
        // Настройка внешнего вида метки
        createLabel(rootView: self.view, label: self.labelPassword, text: "Пароль:", numberOfLines: nil, fontSize: nil, fontWeight: .semibold, textColor: .systemRed, isCenterTextAlignment: false)
        
        // Добавление метки на родительский вью
        self.view.addSubview(self.labelPassword)
        
        // Отключение автоматических ограничений
        self.labelPassword.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта метки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.labelPassword.leftAnchor.constraint(equalTo: self.labelEmail.leftAnchor),
            self.labelPassword.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor,
                                                    constant: (10 * heightOfRootView / iPhone14SceneHeight))
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка текстового поля "Пароль"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация
        self.passwordTextField = UITextField()
        
        // Настройка текстового поля
        createTextField(rootView: self.view, textfield: self.passwordTextField, placeholder: "Введите пароль", borderStyle: .roundedRect)
        
        // Добавление текстового поля на родительский вью
        self.view.addSubview(self.passwordTextField)
        
        // Отключение автоматических ограничений
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта текстового поля на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.passwordTextField.leftAnchor.constraint(equalTo: self.labelPassword.leftAnchor),
            self.passwordTextField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,
                                                          constant: -(50 * widthOfRootView / iPhone14SceneWidth)
                                                         ),
            self.passwordTextField.topAnchor.constraint(equalTo: self.labelPassword.bottomAnchor,
                                                        constant: (10 * heightOfRootView / iPhone14SceneHeight)
                                                       )
        ])
        
        // Добавление обработчика нажатия на текстовое поле
        self.passwordTextField.addTarget(self, action: #selector(removeTextOfLabelNotice), for: .touchDown)
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка метки "Продолжить как гость"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Инициализация объекта
        self.enterAsAGuestLabel = UILabel()
        
        // Настройка внешнего вида метки
        createLabel(rootView: self.view,
                    label: self.enterAsAGuestLabel,
                    text: "Продолжить как гость",
                    numberOfLines: nil,
                    fontSize: nil,
                    fontWeight: .light,
                    textColor: nil,
                    isCenterTextAlignment: false)
        
        // Добавление метки на родительский вью
        self.view.addSubview(self.enterAsAGuestLabel)
        
        // Отключение автоматических ограничений
        self.enterAsAGuestLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта метки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.enterAsAGuestLabel.leftAnchor.constraint(equalTo: self.labelEmail.leftAnchor),
            self.enterAsAGuestLabel.bottomAnchor.constraint(equalTo: self.registrationButton.topAnchor,
                                                            constant: -(30 * heightOfRootView / iPhone14SceneHeight))
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка переключателя "Продолжить как гость"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        // Инициализация
        self.guestSwitch = UISwitch()
        
        // Настройка цвета
        self.guestSwitch.thumbTintColor = .white
        self.guestSwitch.onTintColor = .systemRed
        
        // Перевод переключателя в выключенный режим
        self.guestSwitch.isOn = false
        
        // Добавление метки на родительский вью
        self.view.addSubview(self.guestSwitch)
        
        // Отключение автоматических ограничений
        self.guestSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        // Позиционирование объекта метки на сцене с помощью ограничений
        NSLayoutConstraint.activate([
            self.guestSwitch.rightAnchor.constraint(equalTo: self.registrationButton.rightAnchor),
            self.guestSwitch.centerYAnchor.constraint(equalTo: self.enterAsAGuestLabel.centerYAnchor)
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка кнопки сокрытия текста для текстового поля "Пароль"
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        // Инициализация
        self.buttonForHidePassword = UIButton()
        
        // Установка изображения
        if !passwordTextField.isSecureTextEntry {
            self.buttonForHidePassword.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            self.buttonForHidePassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
        
        // Установка кнопки в качестве правого графического элемента текстового поля
        self.passwordTextField.rightView = self.buttonForHidePassword
        self.passwordTextField.rightViewMode = .always
        
        // Изменения цвета кнопки
        self.passwordTextField.rightView?.tintColor = .systemGray
        
        // Добавление обработчика нажатия на кнопку
        self.buttonForHidePassword.addTarget(self, action: #selector(hideTheText), for: .touchUpInside)
                
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
            self.labelNotice.leftAnchor.constraint(equalTo: self.labelEmail.leftAnchor),
            self.labelNotice.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.labelNotice.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor,
                                                  constant: (10 * heightOfRootView / iPhone14SceneHeight))
        ])
        /*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
        

        
        
    }
    
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - "viewWillAppear" method
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.labelNotice.text = ""
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Переопределение метода "prepare" подготовки к переходу на другую сцену
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let VCOfReservatiion = segue.destination as? ViewControllerOfReservation {
            VCOfReservatiion.user = returnUser(email: self.emailTextField.text!,
                                               password: self.passwordTextField.text!,
                                               users: self.registeredUsers)
        }
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик нажатия на кнопку "Войти"
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    @objc func tryEnter(sender: UIButton) {
        
        if sender ===  buttonEnter {
            if !self.guestSwitch.isOn {
                switch (emailTextField.text, passwordTextField.text) {
                case let (email, password) where (email!.isEmpty) || (password!.isEmpty):
                    self.labelNotice.text = "Заполните все поля"
                case let (email, password):
                    if !userVerification(email: email!, password: password!, users: self.registeredUsers) {
                        self.labelNotice.text = "Введён неправильный Email или пароль"
                    } else {
                        performSegue(withIdentifier: "goToVCOfReservation", sender: nil)
                    }
                }
            } else {
                performSegue(withIdentifier: "goToVCOfReservation", sender: nil)
            }
        }
        
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик нажатия на кнопку "Создать аккаунт"
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    @objc func registrationButtonHandler(sender: UIButton) {
        if sender.isEqual(self.registrationButton) {
            if let naviController = self.navigationController {
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: .main)
                if let vCOfCreatingAccount = mainStoryBoard.instantiateViewController(identifier: "ViewControllerOfCreatingAccount") as? ViewControllerOfCreatingAccount {
                    vCOfCreatingAccount.usersStorage = self.usersStorage
                    vCOfCreatingAccount.registeredUsers = self.registeredUsers
                    vCOfCreatingAccount.delegateToTranferRegisteredUsers = self
                    naviController.pushViewController(vCOfCreatingAccount, animated: true)
                }
            }
        }
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик нажатия на кнопку сокрытия пароля
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    @objc func hideTheText() {
        
        if self.passwordTextField.isSecureTextEntry { self.passwordTextField.isSecureTextEntry = false }
        else { self.passwordTextField.isSecureTextEntry = true }
        
        if !passwordTextField.isSecureTextEntry {
            self.buttonForHidePassword.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            self.buttonForHidePassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
    
    // MARK: - Обработчик нажатия для удаления текста уведомительной метки
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    @objc func removeTextOfLabelNotice() {
        self.labelNotice.text = ""
    }
    /*------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------*/
    
    
}



// MARK: - Подписка на протокол "UpdateUsersStorageDelegate" для передачи данных с новыми пользователями от вью контроллера "ViewControllerOfCreatingAccount" в этот вью контроллер
/*------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------*/
extension ViewControllerOfRegistartion: UpdateUsersStorageDelegate {
    func updateUseresStorage(users: [String : User]) {
        self.registeredUsers = users
    }
}
/*------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------*/
