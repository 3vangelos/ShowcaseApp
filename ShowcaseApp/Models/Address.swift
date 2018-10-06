import Foundation

struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    
    func concatenated() -> String {
        guard let street = street, let suite = suite,
            let zipcode = zipcode, let city = city else {
            return "No Address"
        }
        
        return "\(street), \(suite), \(city), \(zipcode)"
    }
}
