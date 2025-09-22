//
//  LeaguesViewController.swift
//  SportApp
//
//  Created by Nafea Elkassas on 18/09/2025.
//

import UIKit

class LeaguesViewController: UIViewController {
    
    var footballLeagues: [FootballLeague] = []
    var basketballLeagues: [BasketballLeague] = []
    var tennisLeagues: [TennisLeague] = []
    var cricketLeagues: [CricketLeague] = []
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
        
        switch selectedSport {
        case .football:
            
            let presenter = CorePresenter<FootballLeagueProtocol, FootballLeagueRequest>(
                vc: self,
                apiUrl: ApiUrls.leaguesFootball,  // use the base URL without queries
                queryItems: queryItems
            ) { vc, response in
                vc.renderToView(res: response)
            }
            presenter.getDataFromModel()
            
        case .basketball:
            let presenter = CorePresenter<BasketballLeagueProtocol, BasketballLeagueRequest>(
                vc: self,
                apiUrl: ApiUrls.leaguesBasketball,
                queryItems: queryItems
            ) { vc, response in
                vc.renderToView(res: response)
            }
            presenter.getDataFromModel()
            
        case .tennis:
            let presenter = CorePresenter<TennisLeagueProtocol, TennisLeagueRequest>(
                vc: self,
                apiUrl: ApiUrls.leaguesTennis,
                queryItems: queryItems
            ) { vc, response in
                vc.renderToView(res: response)
            }
            presenter.getDataFromModel()
            
        case .cricket:
            let presenter = CorePresenter<CricketLeagueProtocol, CricketLeagueRequest>(
                vc: self,
                apiUrl: ApiUrls.leaguesCricket,
                queryItems: queryItems
            ) { vc, response in
                vc.renderToView(res: response)
            }
            presenter.getDataFromModel()
        }
    }
    
    // fextures Navigation
    private func navigateToFextures(with league: Any, sportType: SportType, leagueName: String, leagueId: Int?){
        let fexturesVC = FexturesViewController(nibName: "FexturesViewController", bundle: nil)
        fexturesVC.selectedLeague = league
        fexturesVC.selectedSport = sportType
        fexturesVC.leagueName = leagueName
        fexturesVC.leagueId = leagueId
        self.navigationController?.pushViewController(fexturesVC, animated: true)
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
        switch selectedSport {
        case .football:
            return footballLeagues.count
        case .basketball:
            return basketballLeagues.count
        case .tennis:
            return tennisLeagues.count
        case .cricket:
            return cricketLeagues.count
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaguesCell", for: indexPath) as! LeaguesTableViewCell
        
        switch selectedSport {
        case .football:
            let league = footballLeagues[indexPath.row]
            cell.leaguesNameLabel.text = league.league_name
            cell.leaguesImageView.loadImage(from: league.league_logo)
            
        case .basketball:
            let league = basketballLeagues[indexPath.row]
            cell.leaguesNameLabel.text = league.league_name
            cell.leaguesImageView.image = UIImage(named: "basketball")
        case .tennis:
            let league = tennisLeagues[indexPath.row]
            cell.leaguesNameLabel.text = league.league_name
            cell.leaguesImageView.image = UIImage(named: "tennis")
            
        case .cricket:
            let league = cricketLeagues[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let sportType = selectedSport else { return }
        switch sportType {
        case.football:
            let league = footballLeagues[indexPath.row]
                        navigateToFextures(with: league, sportType: sportType, leagueName: league.league_name, leagueId: league.league_key)
        case .basketball:
            let league = basketballLeagues[indexPath.row]
            navigateToFextures(with: league, sportType: .basketball, leagueName: league.league_name, leagueId: league.league_key)
        case .tennis:
            let league = tennisLeagues[indexPath.row]
            navigateToFextures(with: league, sportType: .tennis, leagueName: league.league_name, leagueId: league.league_key)
        case .cricket:
            let league = cricketLeagues[indexPath.row]
            navigateToFextures(with: league, sportType: .cricket, leagueName: league.league_name, leagueId: league.league_key)
        default: break
            
        }
        
        
        
    }
    
    
}

//MARK: - Presenter Connection
extension LeaguesViewController: FootballLeagueProtocol, BasketballLeagueProtocol, TennisLeagueProtocol, CricketLeagueProtocol {
    
    func renderToView(res: FootballLeagueRequest) {
        footballLeagues = res.result
        leaguesTableView.reloadData()
    }
    
    func renderToView(res: BasketballLeagueRequest) {
        basketballLeagues = res.result
        leaguesTableView.reloadData()
    }
    
    func renderToView(res: TennisLeagueRequest) {
        tennisLeagues = res.result
        leaguesTableView.reloadData()
    }
    
    func renderToView(res: CricketLeagueRequest) {
        cricketLeagues = res.result
        leaguesTableView.reloadData()
    }
}

