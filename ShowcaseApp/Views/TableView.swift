import UIKit

class TableView: UIView {
    
    //MARK: Variables

    var isLoading: Bool = false {
        didSet {
            if isLoading {
                self.activityIndicatorView.startAnimating()
            } else {
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    //MARK: Private Variables
    
    private let classType: UITableViewCell.Type
    private var cellReuseIdentifier: String {
        return String(describing: self.classType)
    }
    private let tableView = UITableView()
    private let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    //MARK: Init Methods
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    init(cellClass: UITableViewCell.Type, delegate: UITableViewDelegate & UITableViewDataSource) {
        self.classType = cellClass
        super.init(frame: .null)
        
        tableView.delegate = delegate
        tableView.dataSource = delegate
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsMultipleSelection = false
        tableView.register(self.classType,
                           forCellReuseIdentifier: cellReuseIdentifier)
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        activityIndicatorView.hidesWhenStopped = true
        self.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }
}

//MARK: Internal Methods

extension TableView {
    func reload() {
        self.tableView.reloadData()
    }
    
    func dequeCellForIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier,
                                             for: indexPath)
    }
}
