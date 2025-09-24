//
//  LeaguesViewController.swift
//  SportApp
//
//  Created by Nafea Elkassas on 18/09/2025.
//

import UIKit

class LeaguesViewController: UIViewController {
    
    var sportsLeague: [League] = []
    var sportName: String = ""
    var selectedSport: SportType?
    //MARK: - Outlets
    
    @IBOutlet weak var leaguesTableView: UITableView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupPresenters()
        self.title = sportName
        leaguesTableView.backgroundColor = .clear
        
    }
    
    //MARK: - Behaviour
    func setupPresenters() {
        guard let selectedSport = selectedSport else { return }
        let queryItems = [
            URLQueryItem(name: "met", value: "Leagues"),
            URLQueryItem(name: "APIkey", value: AppConstants.apiKey)
        ]
        let apiUrl: String
        switch selectedSport {
        case .football:
            apiUrl = ApiUrls.leaguesFootball
        case .basketball:
            apiUrl = ApiUrls.leaguesBasketball
        case .tennis:
            apiUrl = ApiUrls.leaguesTennis
        case .cricket:
            apiUrl = ApiUrls.leaguesCricket
        }
        
        let presenter = CorePresenter<SportsLeagueProtocol, SprortsLeagueResponse>(
            vc: self,
            apiUrl: apiUrl,
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
        let league = sportsLeague[indexPath.row]
        cell.leaguesNameLabel.text = league.league_name
       // let logoImageUrl = "\(league.league_logo)?width=70&height=70"
        
        if let logoUrl = league.league_logo, !logoUrl.isEmpty {
            cell.leaguesImageView.loadImage(from: "\(logoUrl)?width=70&height=70")
        } else {
            switch selectedSport {
            case .football:
                cell.leaguesImageView.image = UIImage(named: "unknownLeague")
            case .basketball:
                cell.leaguesImageView.image = UIImage(named: "basketBallLeague")
            case .tennis:
                cell.leaguesImageView.image = UIImage(named: "tennisLeague")
            case .cricket:
                cell.leaguesImageView.image = UIImage(named: "cricketUnknownLeague")
            case .none:
                cell.leaguesImageView.image = UIImage(named: "unknownLeague")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let league = sportsLeague[indexPath.row]
        let fixturesVC = FexturesViewController(nibName: "FexturesViewController", bundle: nil)
        
        fixturesVC.selectedSport = selectedSport
        fixturesVC.leagueName = league.league_name
        fixturesVC.leagueId = league.league_key
        
        navigationController?.pushViewController(fixturesVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
//MARK: - Presenter Connection
extension LeaguesViewController: SportsLeagueProtocol {
    
    func renderToView(res: SprortsLeagueResponse) {
        sportsLeague = res.result
        leaguesTableView.reloadData()
    }
}

