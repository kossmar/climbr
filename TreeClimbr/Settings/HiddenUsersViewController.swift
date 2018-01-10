

import UIKit

class HiddenUsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HiddenUserDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: Tableview Delegate / Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.sharedInstance.hiddenUsersArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HiddenUsersTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HiddenUsersCell", for: indexPath) as! HiddenUsersTableViewCell
        
        cell.usernameLabel.text = AppData.sharedInstance.hiddenUsersArr[indexPath.row].name
        cell.delegate = self
        cell.unblockButton.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //MARK: Custom Functions
    
    func unblockUser(senderTag: Int) {
        
        HiddenUsersManager.removeFromHidden(badUser: AppData.sharedInstance.hiddenUsersArr[senderTag]) { (true) in
            HiddenUsersManager.loadHiddenUsers { (User) in
                self.tableView.reloadData()
            }
        }
    }

}
