import UIKit

class UsersView: UIView {
    
    //MARK: Private Variables
    
    private let usersCellReuseIdentifier = "usersCellReuseIdentifier"
    
    private let tableView = UITableView()
    
    //MARK: Init Methods
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    init(_ delegate: UITableViewDelegate & UITableViewDataSource) {
        super.init(frame: .null)
        
        tableView.delegate = delegate
        tableView.dataSource = delegate
        tableView.estimatedRowHeight = UsersTableViewCell.CELL_HEIGHT
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsMultipleSelection = false
        tableView.register(UsersTableViewCell.self, forCellReuseIdentifier: usersCellReuseIdentifier)
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
    }
}

//MARK: Internal Methods

extension UsersView {
    func reload() {
        self.tableView.reloadData()
    }
    
    func dequeCellForIndexPath(_ indexPath: IndexPath) -> UsersTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: usersCellReuseIdentifier,
                                             for: indexPath) as! UsersTableViewCell
    }
}
