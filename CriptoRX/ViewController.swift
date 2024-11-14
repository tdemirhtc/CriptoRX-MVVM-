//
//  ViewController.swift
//  CriptoRX
//
//  Created by Hatice Taşdemir on 6.11.2024.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate {
   
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var cryptoList = [Crypto]()
    //viewmodelı vc de kullanmak için:
    var cryptoVM = CryptoViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.delegate = self
        //bir değişiklik olduğunda etkiliyor mu görmek için:
        setupBindings()
        // aşağıdakş func ile veri indirilecek ve sonrasında cryprovm içerisindeki değişkenlere kayıt edilecektir.
        cryptoVM.requestData()
    }
    //viewmodelda kayıt edilen değişkenleri gözlemleyebilmek ve değişiklik olursa neler olacağını yapmak için:
    private func setupBindings(){
        cryptoVM
            .loading
            .bind(to: self.indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
            
        
       //hata mesajı için olan kısım:
        cryptoVM
            .error
        //gözlemleme işlemlerini yaparken publish ettiğimiz şeye subscribe işlemlerini yaparken observe on kullanırırz.hangi threadtte yapacağını soruyor. dispatchqueue olayı:
            .observe(on: MainScheduler.asyncInstance)
        //içinde hangi veri tipini saklıyor ise onu closure olarak verecektir. cryptoviewmodelda switch case ile yazdığımız publishe eşitlediğimiz errorlardan biri gelecek.
            .subscribe { errorString in
                //nerede göstermek ne yapmak istersem yazarız.
                print(errorString)
            }
            .disposed(by: disposeBag)
        
       /* cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { cryptos in
                self.cryptoList = cryptos
                self.tableView.reloadData()
            }.disposed(by: disposeBag)
        */
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: "CryptoCell", cellType: CryptoTableViewCell.self)) {row,item,cell in
                cell.item = item
            }
            .disposed(by: disposeBag)
    }
    
   /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = cryptoList[indexPath.row].currency
        content.secondaryText = cryptoList[indexPath.row].price
        cell.contentConfiguration = content
        return cell
        
    }
    */


}

