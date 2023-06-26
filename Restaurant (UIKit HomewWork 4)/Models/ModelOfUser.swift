import Foundation

// MARK: - class "User"

class User: NSObject, NSCoding {
    
    // Реализация подписки на протокол "Equatable"
    static func == (lhs: User, rhs: User) -> Bool {
        if (lhs.hashValueOfPassword == rhs.hashValueOfPassword) &&
            (lhs.email == rhs.email) &&
            (lhs.firstName == rhs.firstName) &&
            (lhs.lastName == rhs.lastName) {
            return true
        } else { return false }
    }
    
    // Хранимые свойства объекта
    var firstName: String
    var lastName: String
    var email: String
    var hashValueOfPassword: String // Хэш значение пароля пользователя
    
    // Метод для проверки пароля
    func checkPassword(password: String) -> Bool {
        return (String(password.hashValue) == self.hashValueOfPassword)
    }
    
    // Инициализатор объекта
    init(mailAddress: String, password: String, firstName: String, lastName: String) {
        self.email = mailAddress
        self.hashValueOfPassword = String(password.hashValue)
        self.firstName = firstName
        self.lastName = lastName
    }
    
    // Реализация подписки на протокол "NSCoding"
    /* - - - - - - - - - - - - - - */
    // Метод для кодирования объекта
    func encode(with coder: NSCoder) {
        coder.encode(self.firstName, forKey: "firstName")
        coder.encode(self.lastName, forKey: "lastName")
        coder.encode(self.email, forKey: "email")
        coder.encode(self.hashValueOfPassword, forKey: "hashValueOfPassword")
    }
    
    // Инициализатор для декодирования объекта
    required init?(coder: NSCoder) {
        self.firstName = coder.decodeObject(forKey: "firstName") as? String ?? ""
        self.lastName = coder.decodeObject(forKey: "lastName") as? String ?? ""
        self.email = coder.decodeObject(forKey: "email") as? String ?? ""
        self.hashValueOfPassword = coder.decodeObject(forKey: "hashValueOfPassword") as? String ?? ""
    }
    /* - - - - - - - - - - - - - - */
    
}



// Метод регистрации нового пользователя
func registerUser(firstName: String,
                  lastName: String,
                  email: String,
                  password: String,
                  users: inout [String: User]) -> Bool {
    if !users.contains(where: { (emailAddress: String, user: User) in
        email == emailAddress
    }) {
        let newUser = User(mailAddress: email, password: password, firstName: firstName, lastName: lastName)
        users[newUser.email] = newUser
        return true
    }
    return false
}



// Метод для передачи данных пользователя
func returnUser(email: String, password: String, users: [String: User]) -> User? {
    if users.contains(where: { (emailAddress: String, user: User) in
        email == emailAddress
    }) {
        if (users[email]!.checkPassword(password: password)) {
            return users[email]
        }
    }
    return nil
}



// Метод для удаления зарегестрированного пользователя
func removeUser(email: String, users: inout [String: User]) -> Bool {
    if users.contains(where: { (emailAddress: String, user: User) in
        email == emailAddress
    }) {
        users.removeValue(forKey: "\(email)")
        return true
    }
    return false
}



// Метод для верификации пользователя
func userVerification(email: String, password: String, users: [String: User]) -> Bool {
    if users.contains(where: { (emailAddress: String, user: User) in
        email == emailAddress
    }) {
        return (users[email]!.checkPassword(password: password))
    }
    return false
}


//// MARK: - class "RegisteredUseres"
//
//class RegisteredUsers: NSCoding {
//
//    // Хранимое свойство в виде словаря, состоящего из зарегестрированных пользователей
//    private var registeredUsers: [String: User] = [:]
//
//    // Метод регистрации нового пользователя
//    func registerUser(firstName: String, lastName: String, email: String, password: String) -> Bool {
//        if !registeredUsers.contains(where: { (emailAddress: String, user: User) in
//            email == emailAddress
//        }) {
//            let newUser = User(mailAddress: email, password: password, firstName: firstName, lastName: lastName)
//            registeredUsers[newUser.email] = newUser
//            return true
//        }
//        return false
//    }
//
//    // Метод для удаления зарегестрированного пользователя
//    func removeUser(email: String) -> Bool {
//        if registeredUsers.contains(where: { (emailAddress: String, user: User) in
//            email == emailAddress
//        }) {
//            registeredUsers.removeValue(forKey: "\(email)")
//            return true
//        }
//        return false
//    }
//
//    // Метод для верификации пользователя
//    func userVerification(email: String, password: String) -> Bool {
//        if registeredUsers.contains(where: { (emailAddress: String, user: User) in
//            email == emailAddress
//        }) {
//            return (registeredUsers[email]!.checkPassword(password: password))
//        }
//        return false
//    }
//
//    // Метод для передачи данных пользователя
//    func returnUser(email: String, password: String) -> User? {
//        if registeredUsers.contains(where: { (emailAddress: String, user: User) in
//            email == emailAddress
//        }) {
//            if (registeredUsers[email]!.checkPassword(password: password)) {
//                return registeredUsers[email]
//            }
//        }
//        return nil
//    }
//
//    // Инициализатор объекта
//    init() {
//        self.registeredUsers = [:]
//    }
//
//    // Реализация подписки на протокол "NSCoding"
//    /* - - - - - - - - - - - - - - */
//    // Метод для кодирования объекта
//    func encode(with coder: NSCoder) {
//        coder.encode(self.registeredUsers, forKey: "registeredUsers")
//    }
//
//    // Инициализатор для декодирования объекта
//    required init?(coder: NSCoder) {
//        self.registeredUsers = coder.decodeObject(forKey: "registeredUsers") as? [String: User] ?? [:]
//    }
//    /* - - - - - - - - - - - - - - */
//
//}
