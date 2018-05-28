//
//  ListViewController.swift
//  CloudMemo
//
//  Created by 倉田　隆成 on 2018/05/26.
//  Copyright © 2018年 倉田　隆成. All rights reserved.
//

import UIKit
import NCMB
import SVProgressHUD
class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var memoArray = [NCMBObject]()
    
    @IBOutlet var memoTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTableView.dataSource = self
        memoTableView.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let query = NCMBQuery(className: "Memo")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error?.localizedDescription)  }
            else {
                self.memoArray = result as! [NCMBObject]
                self.memoTableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = memoArray[indexPath.row].object(forKey: "memo") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面の取得
        if segue.identifier == "toDetail" {
            let detailViewController = segue.destination as! DetailViewController
            
            let selectedIndex = memoTableView.indexPathForSelectedRow!
            
            detailViewController.selectedMemo = memoArray[selectedIndex.row]
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
