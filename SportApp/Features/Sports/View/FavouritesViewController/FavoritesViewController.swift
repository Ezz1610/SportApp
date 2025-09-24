//
//  FavoritesViewController.swift
//  SportApp
//
//  Created by Nafea Elkassas on 16/09/2025.
//

import UIKit

class FavoritesViewController: UIViewController {
    //MARK: - Outlets
    
    @IBOutlet weak var favouritesTableView: UITableView!
    
    //MARK: - Properties
    private var favouriteLeagues: [CDLeague] = []
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavourites()
        setupTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavourites()
        favouritesTableView.reloadData()
    }
    
    //MARK: - Behaviour
    private func loadFavourites() {
        let leagues = CoreDataHelper.shared.fetch(CDLeague.self)
        
        // filter unique by leagueKey
        var seenKeys = Set<Int>()
        self.favouriteLeagues = leagues.filter { league in
            if seenKeys.contains(Int(league.leagueKey)) {
                return false
            } else {
                seenKeys.insert(Int(league.leagueKey))
                return true
            }
        }
        
        favouritesTableView.reloadData()
    }
    
    
}
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView(){
        self.title = "Favourite Leagues"
        favouritesTableView.delegate = self
        favouritesTableView.dataSource = self
        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        favouritesTableView.register(nib, forCellReuseIdentifier: "leaguesCell")
        favouritesTableView.backgroundColor = .clear
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaguesCell", for: indexPath) as! LeaguesTableViewCell
        let league = favouriteLeagues[indexPath.row]
        
        cell.leaguesNameLabel.text = league.leagueName
        
        if let logoUrl = league.leagueLogo, !logoUrl.isEmpty {
            cell.leaguesImageView.loadImage(from: "\(logoUrl)?width=70&height=70")
        } else {
            cell.leaguesImageView.image = UIImage(named: "unknownLeague")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    
    
    
}
