//
//  LeaguesViewController.swift
//  SportApp
//
//  Created by Nafea Elkassas on 18/09/2025.
//

import UIKit

class LeaguesViewController: UIViewController {
   
    var sportsLeague: [League] = []

    var selectedSport: SportType?
       //MARK: - Outlets
    
    @IBOutlet weak var leaguesTableView: UITableView!
    
       //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
setupTableView()
        setupPresenters()

    }
    
       //MARK: - Behaviour
    func setupPresenters() {
        guard let selectedSport = selectedSport else { return }
        let queryItems = [
            URLQueryItem(name: "met", value: "Leagues"),
            URLQueryItem(name: "APIkey", value: AppConstants.apiKey)
        ]
        
        let presenter = CorePresenter<SportsLeagueProtocol, SprortsLeagueResponse>(
            vc: self,
            apiUrl: ApiUrls.leaguesBasketball,
            queryItems: queryItems
        ) { vc, response in
            vc.renderToView(res: response)
        }
        presenter.getDataFromModel()
    }


}
   //MARK: - TableView Functions
extension LeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView(){
        leaguesTableView.delegate = self
        leaguesTableView.dataSource = self
        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        leaguesTableView.register(nib, forCellReuseIdentifier: "leaguesCell")

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportsLeague.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaguesCell", for: indexPath) as! LeaguesTableViewCell
        
        switch selectedSport {
        case .football:
            let league = sportsLeague[indexPath.row]
            cell.leaguesNameLabel.text = league.league_name
            cell.leaguesImageView.loadImage(from: league.league_logo)
        case .basketball:
            let league = sportsLeague[indexPath.row]
            cell.leaguesNameLabel.text = league.league_name
            cell.leaguesImageView.image = UIImage(named: "basketball") 
        case .tennis:
            let league = sportsLeague[indexPath.row]
            cell.leaguesNameLabel.text = league.league_name
            cell.leaguesImageView.image = UIImage(named: "tennis")
        case .cricket:
            let league = sportsLeague[indexPath.row]
            cell.leaguesNameLabel.text = league.league_name
            cell.leaguesImageView.image = UIImage(named: "cricket")
        case .none:
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
   //MARK: - Presenter Connection
extension LeaguesViewController: SportsLeagueProtocol {
    
    func renderToView(res: SprortsLeagueResponse) {
        sportsLeague = res.result
        leaguesTableView.reloadData()
    }
}

