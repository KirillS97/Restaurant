import Foundation



protocol UsersStorageProtocol {
    func loadRegisteredUsers() -> [String: User]
    func saveRegisteredUsers(registeredUsers: [String: User]) -> Void
}



class UsersStorage: UsersStorageProtocol {
    
    private let storage = UserDefaults.standard
    
    // Метод для получения пользователей
    func loadRegisteredUsers() -> [String: User] {
        if let archive = storage.object(forKey: "users") as? Data {
            if let decodedUsers = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(archive) as? [String: User] {
                print("users was decoded")
                return decodedUsers
            }
        }
        return [:]
    }
    
    // Метод для сохранения пользователей
    func saveRegisteredUsers(registeredUsers: [String: User]) {
        if let archivedUsers = try? NSKeyedArchiver.archivedData(withRootObject: registeredUsers, requiringSecureCoding: false) {
            print("users was coded")
            self.storage.set(archivedUsers, forKey: "users")
        }
    }
    
    init() {}
    
}
