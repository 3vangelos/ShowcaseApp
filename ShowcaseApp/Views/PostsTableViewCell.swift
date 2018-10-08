import UIKit

class PostsTableViewCell: UITableViewCell {
    
    //MARK: Variables
    
    var title: String? {
        didSet { self.titleLabel.text = title ?? "" }
    }
    
    var body: String? {
        didSet { self.bodyLabel.text = body ?? "" }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        bodyLabel.text = nil
    }
}
