//
//  ViewController.swift
//  SimpsonsQuotes
//
//  Created by Yaroslav on 12.10.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var newQuoteButtonAppearance: UIButton!
    @IBOutlet var quoteLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var characterPicture: UIImageView!
    @IBOutlet var stackView: UIStackView!
    
    private var quotes: [Quote]?
    private var image: UIImage?
    private var numberOfQuote = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newQuoteButtonAppearance.layer.borderColor = UIColor.white.cgColor
        newQuoteButtonAppearance.layer.cornerRadius = 5
        newQuoteButtonAppearance.layer.borderWidth = 3
        
        stackView.isHidden = true
        
        NetworkManager.shared.fetchData(urlString: "https://thesimpsonsquoteapi.glitch.me/quotes?count=20") { quotes in
            self.quotes = quotes
        }
    }
    
    
    @IBAction func newQuoteTapped() {
        
        guard let quotes = quotes else { return }
        
        if numberOfQuote < quotes.count {
            newQuoteButtonAppearance.setTitle("NEW QUOTE", for: .normal)
            
            stackView.isHidden = false
            characterPicture.isHidden = false
            
            quoteLabel.text = "\"\(quotes[numberOfQuote].quote)\""
            nameLabel.text = " -- \(quotes[numberOfQuote].character)"
            
            
            self.image = UIImage(data: ImageManager.shared.fetchImage(url: quotes[numberOfQuote].image)!)
            
            if let image = image {
                characterPicture.image = image
            } else {
                characterPicture.image = UIImage(named: "?")
            }
            numberOfQuote += 1
            
        } else {
            newQuoteButtonAppearance.setTitle("Restart", for: .normal)
            stackView.isHidden = true
            characterPicture.isHidden = true
            numberOfQuote = 0
        }
    }
}
