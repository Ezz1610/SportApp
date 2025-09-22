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
    var selectedLeague: Any?
    var selectedSport: SportType?
    var leagueName: String?
    var leagueId: Int?
    private var upcomingMatches = [Fixture]()
    private var latestMatches = [Fixture]()
  //  private var leagueTeams = [String]()
    
    // mock data
    private let upcomingEvents = [
           ("2023-06-10", "21:00", "Team A", "Team B", "UEFA"),
           ("2023-06-12", "19:30", "Team C", "Team D", "UEFA"),
           ("2023-06-15", "20:00", "Team I", "Team J", "UEFA"),
           ("2023-06-18", "18:45", "Team K", "Team L", "UEFA")
       ]
       
       private let latestEvents = [
           ("2023-05-17", "21:00", "4", "0", "Team E", "Team F", "UEFA"),
           ("2023-05-16", "21:00", "1", "0", "Team G", "Team H", "UEFA"),
           ("2023-05-14", "19:30", "2", "2", "Team M", "Team N", "UEFA"),
           ("2023-05-12", "20:00", "3", "1", "Team O", "Team P", "UEFA"),
           ("2023-05-10", "18:45", "0", "0", "Team Q", "Team R", "UEFA")
       ]
       
       private let leagueTeams = [
           ("Premier League", "football"),
           ("La Liga", "football"),
           ("Serie A", "football"),
           ("Bundesliga", "football"),
           ("Ligue 1", "football")
       ]
    
      //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        self.title = leagueName ?? "Fixtures"
    }
    
    

        
        //MARK: - Layout
    private func setupCollectionView() {
            fexturesCollectionView.collectionViewLayout = createLayout()
            
            // Register cells
            fexturesCollectionView.register(UINib(nibName: "FexturesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FexturesCell")
            fexturesCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TeamCell")
            
            // Register header view
            fexturesCollectionView.register(
                UICollectionReusableView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "HeaderView"
            )
            
            fexturesCollectionView.dataSource = self
            fexturesCollectionView.delegate = self
            fexturesCollectionView.reloadData()
        }
        
        //MARK: - Layout
        func createLayout() -> UICollectionViewCompositionalLayout {
            let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
                switch sectionIndex {
                case 0: // Upcoming Events - Horizontal paging
                    return self.createHorizontalPagingSection()
                case 1: // Latest Events - Vertical scrolling
                    return self.createVerticalScrollingSection()
                case 2: // League Teams - Grid
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
        
    private func createHorizontalPagingSection() -> NSCollectionLayoutSection {
           // Item
           let itemSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1.0),
               heightDimension: .fractionalHeight(1.0)
           )
           let item = NSCollectionLayoutItem(layoutSize: itemSize)

           let groupSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(0.9), // Slightly less than full width for paging effect
               heightDimension: .absolute(160)
           )
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
           
           // Section - Horizontal paging
           let section = NSCollectionLayoutSection(group: group)
           section.orthogonalScrollingBehavior = .groupPaging // This enables horizontal paging
           section.interGroupSpacing = 15
           section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10)
           
           // Header
           let headerSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1.0),
               heightDimension: .absolute(50)
           )
           let header = NSCollectionLayoutBoundarySupplementaryItem(
               layoutSize: headerSize,
               elementKind: UICollectionView.elementKindSectionHeader,
               alignment: .top
           )
           section.boundarySupplementaryItems = [header]
           
           return section
       }
       
       private func createVerticalScrollingSection() -> NSCollectionLayoutSection {
           // Item
           let itemSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1.0),
               heightDimension: .fractionalHeight(1.0)
           )
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           
           // Group - Full width for vertical scrolling
           let groupSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1.0),
               heightDimension: .absolute(120)
           )
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
           
           // Section - Vertical scrolling (default behavior)
           let section = NSCollectionLayoutSection(group: group)
           section.interGroupSpacing = 15
           section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10)
           
           // Header
           let headerSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1.0),
               heightDimension: .absolute(50)
           )
           let header = NSCollectionLayoutBoundarySupplementaryItem(
               layoutSize: headerSize,
               elementKind: UICollectionView.elementKindSectionHeader,
               alignment: .top
           )
           section.boundarySupplementaryItems = [header]
           
           return section
       }
       
       private func createTeamsSection() -> NSCollectionLayoutSection {
           // Item
           let itemSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(0.3),
               heightDimension: .fractionalHeight(1.0)
           )
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
           
           // Group
           let groupSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1.0),
               heightDimension: .absolute(150)
           )
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
           
           // Section
           let section = NSCollectionLayoutSection(group: group)
           section.interGroupSpacing = 10
           section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10)
           
           // Header
           let headerSize = NSCollectionLayoutSize(
               widthDimension: .fractionalWidth(1.0),
               heightDimension: .absolute(50)
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
        case 0: // Upcoming Events
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FexturesCell", for: indexPath) as! FexturesCollectionViewCell
            
            let event = upcomingEvents[indexPath.item]
            
            // Configure cell for upcoming event (no scores)
            cell.matchDateLabel.text = event.0
            cell.matchTimeLabel.text = event.1
            cell.resultLabel.text = "VS" // Show "VS" for upcoming matches
            cell.firstTeamLeagueNameLabel.text = event.4 // League name
            cell.secondTeamLeagueNameLabel.text = event.4 // League name
            cell.firstTeamImageView.image = UIImage(named: "football")
            cell.secondTeamImageView.image = UIImage(named: "football")
            
            return cell
            
        case 1: // Latest Events
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FexturesCell", for: indexPath) as! FexturesCollectionViewCell
            
            let event = latestEvents[indexPath.item]
            
            // Configure cell for latest event (with scores)
            cell.matchDateLabel.text = event.0
            cell.matchTimeLabel.text = event.1
            cell.resultLabel.text = "\(event.2) - \(event.3)" // Show actual score
            cell.firstTeamLeagueNameLabel.text = event.6 // League name
            cell.secondTeamLeagueNameLabel.text = event.6 // League name
            cell.firstTeamImageView.image = UIImage(named: "football")
            cell.secondTeamImageView.image = UIImage(named: "football")
            
            return cell
            
        case 2: // Teams section
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath)
            
            let team = leagueTeams[indexPath.item]
            
            // Remove any existing subviews
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            
            // Create a simple team view
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.bounds.width, height: cell.bounds.height - 30))
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: team.1)
            imageView.backgroundColor = .lightGray
            imageView.layer.cornerRadius = 8
            
            let label = UILabel(frame: CGRect(x: 0, y: cell.bounds.height - 30, width: cell.bounds.width, height: 30))
            label.text = team.0
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12)
            label.numberOfLines = 2
            
            cell.contentView.addSubview(imageView)
            cell.contentView.addSubview(label)
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HeaderView",
                for: indexPath
            )
            
            // Remove any existing subviews
            header.subviews.forEach { $0.removeFromSuperview() }
            
            // Set background color
            header.backgroundColor = .systemBackground
            
            let label = UILabel(frame: CGRect(x: 16, y: 0, width: header.bounds.width - 32, height: header.bounds.height))
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textAlignment = .left
            
            switch indexPath.section {
            case 0:
                label.text = "Upcoming Events"
            case 1:
                label.text = "Latest Events"
            case 2:
                label.text = "League Teams"
            default:
                label.text = ""
            }
            
            header.addSubview(label)
            return header
        }
        
        return UICollectionReusableView()
    }
}
