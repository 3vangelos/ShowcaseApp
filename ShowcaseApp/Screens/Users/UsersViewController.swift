import UIKit

class UsersViewController: UIViewController {
    
    //MARK: Variables
    
    var vm: UsersViewModel? {
        didSet {
            guard let vm = vm else { return }

            vm.reloadViewClosure = { [weak self] () in
                DispatchQueue.main.async {
                    self?.usersView.reload()
                }
            }

            vm.showAlertClosure = { [weak self] () in
                DispatchQueue.main.async {
                    if let message = self?.vm?.alertMessage {
                        self?.showAlert( message )
                    }
                }
            }
        }
    }
    
    //MARK: Private Variables
    
    private lazy var usersView = TableView(cellClass: UsersTableViewCell.self, delegate: self)
    
    //MARK: Init Methods
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("init(nibName:bundle:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Users"
    }
    
    //MARK: View LifeCycle
    
    override func loadView() {
        self.view = usersView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.vm?.fetchData()
    }
}

//MARK: TableViewDelegate & TableViewDataSource

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = self.vm?.cellViewModelAtIndex(indexPath.row) else { return UsersTableViewCell() }
        
        let cell = UsersTableViewCell()
        
        cell.name = cellViewModel.name
        cell.username = cellViewModel.username
        cell.email = cellViewModel.email
        cell.address = cellViewModel.address
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm?.numberOfCells ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let postsViewModel = self.vm?.postsViewModelAtIndex(indexPath.row) else { return }
        let vc = PostsViewController(viewModel: postsViewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: Private Helpers

extension UsersViewController {
    private func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
