//
//  ViewController.swift
//  SieveOfEratosthenes
//
//  Created by Alexander on 10/04/2019.
//  Copyright © 2019 Alexander Selivanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollToTopButton: UIButton!
    @IBOutlet weak var scrollToBottomButton: UIButton!
    
    private var primeNumbers = [Int]()
    private var cellSize = CGSize(width: 50, height: 30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func CalculateButtonTapped(_ sender: UIButton) {
        
        textField.resignFirstResponder()
        
        sender.isEnabled = false
        scrollToTopButton.isEnabled = false
        scrollToBottomButton.isEnabled = false
        
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let maximum = Int(textField.text ?? "0") ?? 0
        
        DispatchQueue.global().async { [weak self] in
            
            self?.primeNumbers = SieveOfEratosthenes.getPrimeArray(for: maximum)
            
            let maximumPrimeNumberString = String(self?.primeNumbers.last ?? 0)
            self?.cellSize = maximumPrimeNumberString.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0)])
            
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                sender.isEnabled = true
                self?.scrollToTopButton.isEnabled = true
                self?.scrollToBottomButton.isEnabled = true
                
                self?.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func scrollToTopTapped(_ sender: Any) {
        guard primeNumbers.count > 0 else { return }
        
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
    @IBAction func scrollToBottomTapped(_ sender: Any) {
        collectionView.scrollToItem(at: IndexPath(item: primeNumbers.endIndex - 1, section: 0), at: .bottom, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return primeNumbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "primeCell", for: indexPath)
        
        if let cell = cell as? PrimeCollectionViewCell {
            cell.label.text = String(primeNumbers[indexPath.item])
        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
}
