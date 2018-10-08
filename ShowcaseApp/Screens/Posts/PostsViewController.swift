import UIKit

class PostsViewController: UITableViewController {
    
    var vm: PostsViewModel? {
        didSet {
            self.title = "\(self.vm?.userName ?? "") Posts"
            
            self.vm?.reloadViewClosure = { [weak self] () in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            
            self.vm?.showAlertClosure = { [weak self] () in
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
        super.viewWillAppear(true)
        
        self.vm?.fetchData()
    }
}

//MARK: TableViewDelegate & TableViewDataSource

extension PostsViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = self.vm?.cellViewModelAtIndex(indexPath.row) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsCell", for: indexPath) as! PostsTableViewCell
        
        cell.title = cellViewModel.title
        cell.body = cellViewModel.body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm?.numberOfCells ?? 0
    }
}

//MARK: Private Helpers

extension PostsViewController {
    private func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
