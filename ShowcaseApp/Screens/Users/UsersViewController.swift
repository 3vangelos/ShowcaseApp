import RxSwift
import UIKit

class UsersViewController: UIViewController {
    
    //MARK: Variables
    
    var vm: UsersViewModel?
    
    //MARK: Private Variables
    
    private lazy var usersView = TableView(cellClass: UsersTableViewCell.self, delegate: self)
    private lazy var disposeBag = DisposeBag()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vm?.users
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { users in
                self.usersView.reload()
            }, onError: { error in
                let message = (error as? APIError)?.message ?? "Error occured"
                self.showAlert(message)
            })
            .disposed(by: disposeBag)
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
