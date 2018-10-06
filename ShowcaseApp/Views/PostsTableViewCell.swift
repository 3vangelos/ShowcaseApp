import SnapKit
import UIKit

class PostsTableViewCell: UITableViewCell {
    
    //MARK: Variables
    
    var title: String? {
        didSet { self.titleLabel.text = title ?? "" }
    }
    
    var body: String? {
        didSet { self.bodyLabel.text = body ?? "" }
    }
    
    //MARK: Private Variables
    
    private let titleLabel = UILabel(font: .subTitle)
    private let bodyLabel = UILabel(font: .body)
    
    //MARK: Init Methods
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let padding = 10.0
        
        self.titleLabel.numberOfLines = 0
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.top.equalTo(self).offset(padding)
            make.right.equalTo(self).offset(-padding)
        }
        
        self.bodyLabel.numberOfLines = 0
        self.addSubview(bodyLabel)
        bodyLabel.snp.makeConstraints { make in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(padding)
            make.bottom.equalTo(self).offset(-2*padding)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        bodyLabel.text = nil
    }
}
