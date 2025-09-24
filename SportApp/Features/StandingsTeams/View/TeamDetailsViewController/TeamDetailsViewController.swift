//
//  TeamDetailsViewController.swift
//  SportApp
//
//  Created by Nafea Elkassas on 24/09/2025.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    //MARK: - Outlets
    
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamPlayersTableView: UITableView!
    
    @IBOutlet weak var teamNameLabel: UILabel!
    //MARK: - Properties
    var selectedTeam: Standing?
    var teamName: String?
    var teamLogo: String?
    var teamId: Int?
    var selectedSport: SportType?
    
    private var teamDetails: TeamDetails?
    private var teamSections: [TeamSection] = []
    
    private var coaches: [Coach] = []
    private var players: [Player] = []
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        fetchTeamDetails()
        guard checkInternetOrShowAlert() else { return }
    }
    
    
    // MARK: - Behaviour
    func setupUI(){
        self.teamNameLabel.text = teamName
        if let logoUrl = teamLogo {
            teamImageView.loadImage(from: logoUrl, placeholder: UIImage(named: "football"))
        }
    }
    
    private func fetchTeamDetails() {
        showLoader()
        guard let sportType = selectedSport, let teamId = teamId else { return }
        
        let queryItems = [
            URLQueryItem(name: "met", value: "Teams"),
            URLQueryItem(name: "APIkey", value: AppConstants.apiKey),
            URLQueryItem(name: "teamId", value: "\(teamId)")
        ]
        
        var apiUrl = ""
        switch sportType {
        case .football:   apiUrl = ApiUrls.football
        case .basketball: apiUrl = ApiUrls.basketball
        case .tennis:     apiUrl = ApiUrls.tennis
        case .cricket:    apiUrl = ApiUrls.cricket
        }
        
        let presenter = CorePresenter<TeamDetailsViewController, TeamDetailsResponse>(
            vc: self,
            apiUrl: apiUrl,
            queryItems: queryItems
        ) { vc, response in
            vc.handleTeamDetailsResponse(response)
            vc.hideLoader()
        }
        presenter.getDataFromModel()
    }
    
    func handleTeamDetailsResponse(_ response: TeamDetailsResponse) {
        if let teamDetails = response.result.first {
            self.teamDetails = teamDetails
            organizeTeamData()
            teamPlayersTableView.reloadData()
        }
    }
    
    private func organizeTeamData() {
        coaches = teamDetails?.coaches ?? []
        players = teamDetails?.players ?? []
        teamPlayersTableView.reloadData()
    }
}

   //MARK: - TableView Methods
extension TeamDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView(){
        teamPlayersTableView.delegate = self
        teamPlayersTableView.dataSource = self
        teamPlayersTableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "playerCell")
        teamPlayersTableView.rowHeight = 150
        teamPlayersTableView.estimatedRowHeight = 150
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var sections = 0
        if !coaches.isEmpty { sections += 1 }
        if !players.isEmpty { sections += 1 }
        return sections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && !coaches.isEmpty {
            return coaches.count
        } else {
            return players.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as? PlayerTableViewCell else {
            return UITableViewCell()
        }
        
        // Configure image view for consistent sizing
        cell.playerImageView.contentMode = .scaleAspectFill
        cell.playerImageView.clipsToBounds = true
        cell.playerImageView.layer.cornerRadius = 8
        
        if !coaches.isEmpty && indexPath.section == 0 {
            let coach = coaches[indexPath.row]
            cell.playerNameLabel.text = coach.coachName
            cell.playerRoleLabel.text = "Coach"
            cell.playerImageView.image = UIImage(named: "ghostPlayer")
            cell.playerImageView.tintColor = .systemBlue
        } else {
            let player = players[indexPath.row]
            cell.playerNameLabel.text = player.playerName
            cell.playerRoleLabel.text = player.playerType
            
            if let playerImageUrl = player.playerImage {
                cell.playerImageView.loadImage(from: playerImageUrl, placeholder: UIImage(named: "ghostPlayer"))
            } else {
                cell.playerImageView.image = UIImage(named: "ghostPlayer")
                cell.playerImageView.tintColor = .systemGray
            }
            
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if section == 0 && !coaches.isEmpty {
                return "Coaches"
            } else if (!coaches.isEmpty && section == 1) || (coaches.isEmpty && section == 0) {
                return "Players"
            }
            return nil
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = players[indexPath.row]
showPlayerDetailsAlert(player: player)
    }
    
}

   //MARK: - Alert Related Functions
extension TeamDetailsViewController{
    
    func showPlayerDetailsAlert(player: Player) {
        let captainText = (player.playerIsCaptain?.isEmpty == false) ? "Yes" : "No"
        
        let message = """
        Number: \(player.playerNumber ?? "-")
        Country: \(player.playerCountry ?? "Unknown")
        Age: \(player.playerAge ?? "-")
        Captain: \(captainText)
        Team: \(self.teamName!)
        """

        let alert = UIAlertController(
            title: player.playerName ?? "Player",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }}
