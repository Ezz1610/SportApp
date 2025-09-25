//
//  OnbardingView3.swift
//  SportApp
//
//  Created by mohamed ezz on 25/09/2025.
//

import UIKit

class TennisView: UIViewController {

    @IBOutlet weak var tennisImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tennisImage.image = UIImage(named: "basckitball_onboarding")

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
