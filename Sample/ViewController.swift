//
//  ViewController.swift
//  Sample
//
//  Created by APPLE on 03/07/23.
//

import UIKit
import AppCenter
import AppCenterCrashes
import AppCenterAnalytics
class ViewController: UIViewController {
    
    
    @IBOutlet weak var samplecollections: UICollectionView!
    
    lazy var testarray = [Samplecollection]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppCenter.start(withAppSecret: "784cd1aa-b410-433c-9088-06f85915b20e", services: [Crashes.self])
        self.test()
        
    }
    
    func test() {
        
        let refresh = UIRefreshControl()
        
        let ve = NSMutableAttributedString(string: "Pull to refresh")
        ve.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], range: NSRange(location: 0, length: 15))
        refresh.attributedTitle = ve
        refresh.tintColor = .red
        refresh.addTarget(self, action: #selector(didrefresh(_:)), for: .valueChanged)
        self.samplecollections.insertSubview(refresh, at: 0)
        let nib = UINib(nibName: "TestCollectionViewCell", bundle: nil)
        self.samplecollections.register(nib, forCellWithReuseIdentifier: "TestCollectionViewCell")
        var startvalue = 0
        
        for index in 0...4 {
            
            self.testarray.append(Samplecollection(displaytitle: "Harikrishnan",Rowsvalue: nil))
            
            for value in 0...5 {
                
                if let value = self.testarray[startvalue].Rowsvalue {
                    self.testarray[startvalue].Rowsvalue?.append(Rowsvalue(displaytitle: "Hari",displayimage: "Sample"))
                } else {
                    let rows = Rowsvalue(displaytitle: "Hari",displayimage: "sample")
                    self.testarray[startvalue].Rowsvalue = [rows]
                }
                
                
            }
            
            startvalue += 1
        }
        
        self.samplecollections.delegate = self
        self.samplecollections.dataSource = self
        
        self.samplecollections.reloadData()
        
    }
    
    @objc func didrefresh(_ sender: UIRefreshControl) {
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute:{[weak self] in
            
            sender.endRefreshing()
            
        })
    }
    
    
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.testarray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.testarray[section].Rowsvalue?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.samplecollections.dequeueReusableCell(withReuseIdentifier: "TestCollectionViewCell", for: indexPath) as! TestCollectionViewCell
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.samplecollections.frame.width / 4) - 10, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            guard let view = self.samplecollections.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TestCollectionReusableView", for: indexPath) as? TestCollectionReusableView else {return UICollectionReusableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))}
            
            view.labeltxt.text = self.testarray[indexPath.item].displaytitle
            return view
        default:
            assert(false,"Invalid element type")
        }
        
    }
    
    
    
}
struct Samplecollection {
    
    var displaytitle: String?
    var Rowsvalue: [Rowsvalue]?
}


struct Rowsvalue {
    
    var displaytitle: String?
    var displayimage: String?
}
