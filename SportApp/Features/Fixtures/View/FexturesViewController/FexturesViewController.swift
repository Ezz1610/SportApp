//
//  FexturesViewController.swift
//  SportApp
//
//  Created by Nafea Elkassas on 21/09/2025.
//

import UIKit

class FexturesViewController: UIViewController {
    
    
    //MARK: - Outlets
    @IBOutlet weak var fexturesCollectionView: UICollectionView!
    
    //MARK: - Properties
    var selectedLeague: League!
    var selectedSport: SportType?
    var leagueName: String?
    var leagueId: Int?
    private var upcomingEvents = [Fixture]()
    private var latestEvents = [Fixture]()
    private var leagueTeams = [Standing]()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchLeagueData()
        setupUI()
        guard checkInternetOrShowAlert() else { return }
    }
    
    //MARK: - Behaviour
    
    private func setupUI(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(makeLeagueFavourite))
        self.title = leagueName ?? "Fixtures"
        
    }
    @objc func makeLeagueFavourite() {
        guard let id = leagueId, let name = leagueName else { return }
        
        let context = CoreDataHelper.shared.viewContext
      //  let league = CDLeague(context: context)
        
        //        let  leagueModel = CDLeague(context: context)
        //        leagueModel.leagueKey = Int64(id)
        //        leagueModel.leagueName = leagueName
        
        //        CoreDataHelper.shared.save(leagueModel)
        CoreDataHelper.shared.saveLeague(league: self.selectedLeague)
        //        league.leagueKey = Int64(id)
        //        league.leagueName = name
        //        CoreDataHelper.shared.save(self.selectedLeague)
        //       context.insert(league)
        
        do {
            try context.save()
            print("✅ \(name) has been added to favorites.")
        } catch {
            print("❌ Failed saving favorite: \(error)")
        }
    }
    
    private func setupCollectionView() {
        fexturesCollectionView.collectionViewLayout = createLayout()
        fexturesCollectionView.register(UINib(nibName: "FexturesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FexturesCell")
        fexturesCollectionView.register(UINib(nibName: "TeamsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TeamCell")
        fexturesCollectionView.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HeaderView"
        )
       // fexturesCollectionView.backgroundColor = .clear
        fexturesCollectionView.dataSource = self
        fexturesCollectionView.delegate = self
        fexturesCollectionView.reloadData()
    }
    
    private func fetchLeagueData() {
        showLoader()
        guard let sportType = selectedSport, let leagueId = leagueId else { return }
        fetchUpcomingEvents(sportType: sportType, leagueId: leagueId)
        fetchLatestEvents(sportType: sportType, leagueId: leagueId)
        fetchStandings(sportType: sportType, leagueId: leagueId)
        
    }
    
    // fetching upcoming and latest events methods
    private func fetchUpcomingEvents(sportType: SportType, leagueId: Int) {
        let fromDate = AppConstants.getNowDate()
        let toDate = AppConstants.getLastDateOfCurrentMonth() ?? AppConstants.getNowDate()
        
        // same like previous one
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let queryItems = [
            URLQueryItem(name: "met", value: "Fixtures"),
            URLQueryItem(name: "APIkey", value: AppConstants.apiKey),
            URLQueryItem(name: "from", value: formatter.string(from: fromDate)),
            URLQueryItem(name: "to", value: formatter.string(from: toDate)),
            URLQueryItem(name: "leagueId", value: "\(leagueId)")
        ]
        
        var apiUrl = ""
        switch sportType {
        case .football:   apiUrl = ApiUrls.footballFixtures
        case .basketball: apiUrl = ApiUrls.basketballFixtures
        case .tennis:     apiUrl = ApiUrls.tennisFixtures
        case .cricket:    apiUrl = ApiUrls.cricketFixtures
        }
        
        let presenter = CorePresenter<FexturesViewController, FixturesResponse>(
            vc: self,
            apiUrl: apiUrl,
            queryItems: queryItems
        ) { vc, response in
            vc.handleUpcomingEventsResponse(response)
        }
        presenter.getDataFromModel()
    }
    
    // Latest Events → first day of month until today
    // from 2025-09-01 -> 2025-09-14
    // make functon returns this
    private func fetchLatestEvents(sportType: SportType, leagueId: Int) {
        let fromDate = AppConstants.getDate13DaysAgo() // 13 days ago
        let toDate = AppConstants.getYesterdaysDate()  // Yesterday
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        // DEBUG: Print the dates to see what's being requested
        print("Latest Events Date Range:")
        print("From: \(formatter.string(from: fromDate))")
        print("To: \(formatter.string(from: toDate))")
        print("Today: \(formatter.string(from: Date()))")
        
        let queryItems = [
            URLQueryItem(name: "met", value: "Fixtures"),
            URLQueryItem(name: "APIkey", value: AppConstants.apiKey),
            URLQueryItem(name: "from", value: formatter.string(from: fromDate)),
            URLQueryItem(name: "to", value: formatter.string(from: toDate)),
            URLQueryItem(name: "leagueId", value: "\(leagueId)")
        ]
        
        var apiUrl = ""
        switch sportType {
        case .football:   apiUrl = ApiUrls.latestEventsFootballFixtures
        case .basketball: apiUrl = ApiUrls.latestEventsBasketballFixtures
        case .tennis:     apiUrl = ApiUrls.latestEventsTennisFixtures
        case .cricket:    apiUrl = ApiUrls.latestEventsCricketFixtures
        }
        
        let presenter = CorePresenter<FexturesViewController, FixturesResponse>(
            vc: self,
            apiUrl: apiUrl,
            queryItems: queryItems
        ) { vc, response in
            vc.handleLatestEventsResponse(response)
        }
        presenter.getDataFromModel()
    }
    
    private func fetchStandings(sportType: SportType, leagueId: Int) {
        let queryItems = [
            URLQueryItem(name: "met", value: "Standings"),
            URLQueryItem(name: "APIkey", value: AppConstants.apiKey),
            URLQueryItem(name: "leagueId", value: "\(leagueId)")
        ]
        
        var apiUrl = ""
        switch sportType {
        case .football:   apiUrl = ApiUrls.football
        case .basketball: apiUrl = ApiUrls.basketball
        case .tennis:     apiUrl = ApiUrls.tennis
        case .cricket:    apiUrl = ApiUrls.cricket
        }
        
        let presenter = CorePresenter<FexturesViewController, StandingsTeamsResponse>(
            vc: self,
            apiUrl: apiUrl,
            queryItems: queryItems
        ) { vc, response in
            vc.handleStandingsResponse(response)
        }
        presenter.getDataFromModel()
    }
    
    func handleStandingsResponse(_ response: StandingsTeamsResponse){
        leagueTeams = response.result.total
        
        fexturesCollectionView.reloadData()
    }
    
    func handleUpcomingEventsResponse(_ response: FixturesResponse) {
        hideLoader()
        upcomingEvents = response.result
        fexturesCollectionView.reloadData()
    }
    
    func handleLatestEventsResponse(_ response: FixturesResponse) {
        latestEvents = response.result
        fexturesCollectionView.reloadData()
    }
    
    
    
    
    
    //MARK: - Compositional CollectionView Methods
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            case 0:
                return self.createHorizontalPagingSection()
            case 1:
                return self.createVerticalScrollingSection()
            case 2:
                return self.createTeamsSection()
            default:
                return nil
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        layout.configuration = config
        
        return layout
    }
    
    // first section which stands for upcoming events
    private func createHorizontalPagingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .absolute(170)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(30)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    // handling latest events
    private func createVerticalScrollingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(130)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(30)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    // teams section
    private func createTeamsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(180)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
        // section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(30)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}

//MARK: - UICollectionView DataSource & Delegate
extension FexturesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return upcomingEvents.count
        case 1: return latestEvents.count
        case 2: return leagueTeams.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FexturesCell", for: indexPath) as! FexturesCollectionViewCell
            configureUpcomingEventCell(cell, at: indexPath)
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FexturesCell", for: indexPath) as! FexturesCollectionViewCell
            configureLatestEventCell(cell, at: indexPath)
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath)
            configureTeamCell(cell as! TeamsCollectionViewCell, at: indexPath)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    private func configureFixtureCell(
        _ cell: FexturesCollectionViewCell,
        with fixture: Fixture,
        isUpcoming: Bool
    ) {
        cell.matchDateLabel.text = AppConstants.formatMatchDate(fixture.eventDate)
        
        cell.matchTimeLabel.text = fixture.eventTime
        cell.firstTeamLeagueNameLabel.text = fixture.eventHomeTeam
        cell.secondTeamLeagueNameLabel.text = fixture.eventAwayTeam
        
        if isUpcoming {
            cell.resultLabel.text = ""
        } else {
            if let finalResult = fixture.eventFinalResult, !finalResult.isEmpty {
                cell.resultLabel.text = finalResult
            } else {
                cell.resultLabel.text = "Unknown"
            }
        }
        
        cell.firstTeamImageView.loadImage(from: fixture.homeTeamLogo,
                                          placeholder: UIImage(named: "football"))
        cell.secondTeamImageView.loadImage(from: fixture.awayTeamLogo,
                                           placeholder: UIImage(named: "football"))
        
        configureTextColors(for: cell)
        cell.containerView.layer.borderWidth = 1
        cell.containerView.layer.borderColor = (isUpcoming ? UIColor.systemGray4 : UIColor.systemGreen).cgColor
        cell.containerView.backgroundColor = .systemBackground
    }
    
    private func configureUpcomingEventCell(_ cell: FexturesCollectionViewCell, at indexPath: IndexPath) {
        guard indexPath.item < upcomingEvents.count else { return }
        let fixture = upcomingEvents[indexPath.item]
        configureFixtureCell(cell, with: fixture, isUpcoming: true)
    }
    
    private func configureLatestEventCell(_ cell: FexturesCollectionViewCell, at indexPath: IndexPath) {
        guard indexPath.item < latestEvents.count else { return }
        let fixture = latestEvents[indexPath.item]
        configureFixtureCell(cell, with: fixture, isUpcoming: false)
    }
    
    private func configureTextColors(for cell: FexturesCollectionViewCell) {
        let primaryTextColor = UIColor.white
        let secondaryTextColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        let accentColor = UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
        
        cell.firstTeamLeagueNameLabel.textColor = primaryTextColor
        cell.secondTeamLeagueNameLabel.textColor = primaryTextColor
        cell.resultLabel.textColor = accentColor
        cell.matchDateLabel.textColor = secondaryTextColor
        cell.matchTimeLabel.textColor = secondaryTextColor
    }
    
    // standalone cell , not shared with other sections
    
    private func configureTeamCell(_ cell: TeamsCollectionViewCell, at indexPath: IndexPath) {
        guard indexPath.item < leagueTeams.count else { return }
        
        let standing = leagueTeams[indexPath.item]
        
        let position = standing.standingPlace ?? 0
        let teamName = standing.standingTeam ?? "Unknown Team"
        let logoUrl = standing.teamLogo ?? ""
        
        cell.teamsNameLabel.text = "\(position). \(teamName)"
        cell.teamsImageView.loadImage(from: logoUrl, placeholder: UIImage(named: "football"))
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HeaderView",
                for: indexPath
            )
            
            header.subviews.forEach { $0.removeFromSuperview() }
            header.backgroundColor = .clear
            
            let label = UILabel(frame: CGRect(x: 16, y: 0, width: header.bounds.width - 32, height: header.bounds.height))
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textAlignment = .left
            label.textColor = .label
            
            switch indexPath.section {
            case 0:
                label.text = "Upcoming Events (\(upcomingEvents.count))"
            case 1:
                if latestEvents.isEmpty {
                    label.text = "No Recent Matches"
                } else {
                    label.text = "Latest Events (\(latestEvents.count))"
                }
            case 2:
                label.text = "League Standings (\(leagueTeams.count))"
            default:
                label.text = ""
            }
            
            header.addSubview(label)
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0 where indexPath.item < upcomingEvents.count:
            let fixture = upcomingEvents[indexPath.item]
            showFixtureDetail(fixture, isUpcoming: true)
            
        case 1 where indexPath.item < latestEvents.count:
            let fixture = latestEvents[indexPath.item]
            showFixtureDetail(fixture, isUpcoming: false)
            
        case 2 where indexPath.item < leagueTeams.count:
            let team = leagueTeams[indexPath.item]
            navigateToTeamDetails(with: team)
            
        default:
            break
        }
    }
    
    
    
    //MARK: - Helper and  Alerts showing functions
    
    private func navigateToTeamDetails(with team: Standing) {
        let teamVC = TeamDetailsViewController(nibName: "TeamDetailsViewController", bundle: nil)
        
        teamVC.selectedTeam = team
        teamVC.teamName = team.standingTeam
        teamVC.teamLogo = team.teamLogo
        teamVC.teamId = team.teamKey
        teamVC.selectedSport = selectedSport
        
        navigationController?.pushViewController(teamVC, animated: true)
    }
    
    private func showFixtureDetail(_ fixture: Fixture, isUpcoming: Bool) {
        let alert = UIAlertController(
            title: "\(fixture.eventHomeTeam) vs \(fixture.eventAwayTeam)",
            message: """
                Date: \(fixture.eventDate)
                Time: \(fixture.eventTime)
                \(isUpcoming ? "Status: Upcoming" : "Result: \(fixture.eventFinalResult)")
                League: \(fixture.leagueName)
                """,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // will be replaced with real team data
    private func showTeamDetail(_ teamName: String) {
        let alert = UIAlertController(
            title: teamName,
            message: "Team details will be shown here",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
}

