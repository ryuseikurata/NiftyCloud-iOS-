//
//  DetailViewController.swift
//  CloudMemo
//
//  Created by 倉田　隆成 on 2018/05/26.
//  Copyright © 2018年 倉田　隆成. All rights reserved.
//

import UIKit
import NCMB

class DetailViewController: UIViewController {
    var selectedMemo: NCMBObject!
    @IBOutlet var memoTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.text = selectedMemo.object(forKey: "memo") as! String
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func update() {
        selectedMemo.setObject(memoTextView.text, forKey: "memo")
        selectedMemo.saveInBackground { (error) in
            if error != nil{
                print("error")
            }else{
            //成功
            self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func delete() {
        selectedMemo.deleteInBackground { (error) in
            if error != nil {
                print(error)
            }
            else {
                //削除
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
