import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let address: Address
}
