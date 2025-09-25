//
//  OnbardingView1.swift
//  SportApp
//
//  Created by mohamed ezz on 25/09/2025.
//

import UIKit

class FootballView: UIViewController {

    

    @IBOutlet weak var footballImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        footballImage.image = UIImage(named: "basckitball_onboarding")

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
