import UIKit

class UsersTableViewCell: UITableViewCell {
    
    //MARK: Variables

    var name: String? {
        didSet { self.nameLabel.text = "👤 " + (name ?? "-") }
    }
    
    var username: String? {
        didSet { self.userNameLabel.text = "👤 " + (username ?? "-") }
    }
    
    var email: String? {
        didSet { self.emailLabel.text = "✉️ " + (email ?? "-") }
    }
    
    var address: String? {
        didSet { self.addressLabel.text = address ?? "-" }
    }

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        userNameLabel.text = nil
        emailLabel.text = nil
        addressLabel.text = nil
    }
}
