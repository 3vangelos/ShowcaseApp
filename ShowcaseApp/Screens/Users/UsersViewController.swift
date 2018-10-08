import UIKit

class UsersViewController: UITableViewController {
    
    //MARK: Variables
    
    var vm: UsersViewModel? {
        didSet {
            guard let vm = vm else { return }

            vm.reloadViewClosure = { [weak self] () in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
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
    
    //MARK: View LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.vm?.fetchData()
    }
}

//MARK: TableViewDelegate & TableViewDataSource

extension UsersViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = self.vm?.cellViewModelAtIndex(indexPath.row) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersCell", for: indexPath) as! UsersTableViewCell
        
        cell.name = cellViewModel.name
        cell.username = cellViewModel.username
        cell.email = cellViewModel.email
        cell.address = cellViewModel.address
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm?.numberOfCells ?? 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let indexPath = tableView.indexPathForSelectedRow,
            let postsViewModel = self.vm?.postsViewModelAtIndex(indexPath.row),
            let postsVC = segue.destination as? PostsViewController else {
                return
        }
        
        postsVC.vm = postsViewModel
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
