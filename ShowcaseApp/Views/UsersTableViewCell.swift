import SnapKit
import UIKit

class UsersTableViewCell: UITableViewCell {
    
    //MARK: Constants
    
    static let CELL_HEIGHT: CGFloat = 120.0
    
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
    
    //MARK: Private Variables
    
    private let nameLabel = UILabel(font: .body)
    private let userNameLabel = UILabel(font: .body)
    private let emailLabel = UILabel(font: .body)
    private let addressIcon = UILabel(font: .body, text: "🏠 ")
    private let addressLabel = UILabel(font: .body)

    //MARK: Init Methods
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let padding = 10.0
        
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.top.equalTo(self).offset(padding)
            make.right.equalTo(self).offset(-padding)
        }

        self.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(padding)
        }
        
        self.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.left.right.equalTo(userNameLabel)
            make.top.equalTo(userNameLabel.snp.bottom).offset(padding)
        }
        
        self.addSubview(addressIcon)
        addressIcon.snp.makeConstraints { make in
            make.left.equalTo(emailLabel)
            make.width.greaterThanOrEqualTo(20)
            make.top.equalTo(emailLabel.snp.bottom).offset(padding)
        }
        
        self.addressLabel.numberOfLines = 0
        self.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { make in
            make.left.equalTo(addressIcon.snp.right)
            make.right.equalTo(emailLabel)
            make.top.equalTo(addressIcon)
            make.bottom.equalTo(self).offset(-3*padding)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        userNameLabel.text = nil
        emailLabel.text = nil
        addressLabel.text = nil
    }
}
