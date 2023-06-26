import Foundation

protocol UpdateUsersStorageDelegate {
    func updateUseresStorage(users: [String: User]) -> Void
}
