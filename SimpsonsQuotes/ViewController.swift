//
//  ViewController.swift
//  SimpsonsQuotes
//
//  Created by Yaroslav on 12.10.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import AVFoundation
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
    private var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newQuoteButtonAppearance.layer.borderColor = UIColor.white.cgColor
        newQuoteButtonAppearance.layer.cornerRadius = 5
        newQuoteButtonAppearance.layer.borderWidth = 3
                
        stackView.isHidden = true
        
        NetworkManager.shared.fetchData(urlString: "https://thesimpsonsquoteapi.glitch.me/quotes?count=10") { [weak self ]quotes in
            self?.quotes = quotes
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tableVC = segue.destination as? ListOfQuotesTable else { return }
        tableVC.tableQuotes = quotes
    }
    
    @IBAction func newQuoteTapped() {
        
        guard let quotes = quotes else { return }
        newQuoteButtonAppearance.setTitle("NEXT", for: .normal)
        
        if numberOfQuote < quotes.count - 1 {
                        
            stackView.isHidden = false
            characterPicture.isHidden = false
            
            updateUI()
            
            numberOfQuote += 1
            
        } else if numberOfQuote == quotes.count - 1 {
            
            updateUI()
                        
            NetworkManager.shared.fetchData(urlString: "https://thesimpsonsquoteapi.glitch.me/quotes?count=10") { quotes in
                self.quotes = quotes
            }
            
            numberOfQuote = 0
        }
    }
    
    @IBAction func playMusic() {
        if let player = player, player.isPlaying {
            player.stop()
        } else {
            let urlString = Bundle.main.path(forResource: "The Simpsons", ofType: "mp3")
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else { return }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else { return }
                
                player.play()
                
            } catch {
                print("Something went wrong!")
            }
        }
    }
    
    private func updateUI() {
        
        guard let quotes = quotes else { return }

        quoteLabel.text = "\"\(quotes[numberOfQuote].quote)\""
        nameLabel.text = " -- \(quotes[numberOfQuote].character)"
        
        
        image = UIImage(data: ImageManager.shared.fetchImage(url: quotes[numberOfQuote].image) ?? Data())
        
        characterPicture.image = image ?? UIImage(named: "?")

    }
}
