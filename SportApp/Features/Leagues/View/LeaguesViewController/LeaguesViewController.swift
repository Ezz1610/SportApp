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
            switch selectedSport {
            case .football:
                let presenter = FootballLeaguePresenter(vc: self)
                presenter.getDataFromModel()
            case .basketball:
                let presenter = BasketballLeaguePresenter(vc: self)
                presenter.getDataFromModel()
            case .tennis:
                let presenter = TennisLeaguePresenter(vc: self)
                presenter.getDataFromModel()
            case .cricket:
                let presenter = CricketLeaguePresenter(vc: self)
                presenter.getDataFromModel()
            }
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

