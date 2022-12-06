//
//  OrganizationPageViewController.swift
//  Gro-test
//
//  Created by Long Do on 10/18/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices

class OrganizationPageViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var organizationImageView: UIImageView!
    @IBOutlet weak var upcomingEventsCollectionView: UICollectionView!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var eventsButton: UIButton!
    @IBOutlet weak var subscribeButton: UIButton!
    
    @IBOutlet weak var OrgName: UILabel!
    @IBOutlet weak var updateButtont: UIButton!
    @IBOutlet weak var descriptionTextfield: UITextView!
    var userEmail = ""
    var orgAvartar:UIImage = UIImage()
    var runned = false
    var eventImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("start of view did load - useremail is: \(userEmail)")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 90)
        self.OrgName.text = "loading"
        // Set up org page collection layout
        upcomingEventsCollectionView.collectionViewLayout = layout
        upcomingEventsCollectionView.delegate = self
        upcomingEventsCollectionView.dataSource = self
        upcomingEventsCollectionView.register(UpcomingEventsCollectionViewCell.nib(), forCellWithReuseIdentifier: "UpcomingEventsCollectionViewCell")

        // Set org logo layout
        organizationImageView.backgroundColor = UIColor.gray
        organizationImageView.layer.masksToBounds = true
        organizationImageView.layer.cornerRadius = organizationImageView.frame.height / 2
        
        // Set button layout
        contactButton.layer.cornerRadius = 5
        eventsButton.layer.cornerRadius = 5
        subscribeButton.layer.cornerRadius = 5

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (selectedOrg == nil) {
            DispatchQueue.global(qos: .userInteractive).async {
                // Retrieving Data from backend
                DataManager.app.retrieveUserData(email: self.userEmail){
                    result in
                    self.runned = true
                    let curOrgData:UserData = result[0]
                    self.OrgName.text = curOrgData.userName
                    selectedOrg = curOrgData.userName
                    self.descriptionTextfield.text = curOrgData.description
                    self.orgAvartar = curOrgData.avatar
                }
                
                // Retrieve event images from backend
                DataManager.app.retrieveEventData(OrgName: self.OrgName.text!) {
                    result in
                    for each in result {
                        self.eventImages.append(each.image)
                    }
                }
            }
        } else {
            DispatchQueue.global(qos: .userInteractive).async {
                DataManager.app.retrieveUserEmail(userName: selectedOrg as! String, type: "orgData") {
                    result in
                    
                    DispatchQueue.main.async {
                        self.userEmail = result.email
                        
                        // Retrieving Data from backend
                        DataManager.app.retrieveUserData(email: self.userEmail){
                            result in
                            self.runned = true
                            let curOrgData:UserData = result[0]
                            self.OrgName.text = curOrgData.userName
                            selectedOrg = curOrgData.userName
                            self.descriptionTextfield.text = curOrgData.description
                            self.orgAvartar = curOrgData.avatar
                        }
                        
                        // Retrieve event images from backend
                        DataManager.app.retrieveEventData(OrgName: self.OrgName.text!) {
                            result in
                            self.eventImages = []
                            for each in result {
                                self.eventImages.append(each.image)
                            }
                        }
                        self.upcomingEventsCollectionView.reloadData()
                    }
                }
            }
        }
        
    }
    
    @IBAction func updateInfoButton(_ sender: Any) {
        if (runned) {
            DataManager.app.UploadUserData(email: self.userEmail, orgAvatar: self.orgAvartar, orgDescription: self.descriptionTextfield.text, type: "orgData", userName: self.OrgName.text as! String)
        }
    }
    
    @IBAction func subscribeButtonPressed(_ sender: Any) {
        DataManager.app.subscribeToOrg(orgName: OrgName.text!, orgEmail: userEmail, userEmail: myEmail)
        print("subscribed")
    }
    @IBAction func contactButtonPressed(_ sender: Any) {
        if MFMailComposeViewController.canSendMail(){
            //create the email view controller and present itct
            let vc = MFMailComposeViewController()
            vc.mailComposeDelegate = self
            vc.setSubject("Contact us")
            vc.setToRecipients([self.userEmail])
            vc.setMessageBody("<h1>Enter your message here!</h1>", isHTML: true)
            present(vc, animated: true)
        }
        else{
            //in case the mail app is not available (on simulators!)
            //display an alert instead
            let emailAlertController = UIAlertController(
                title: "Email/Mail not available",
                message: "Unable to send an email on this device",
                preferredStyle: .alert)
            emailAlertController.addAction(UIAlertAction(title: "OK",
                                               style: .default))
            self.present(emailAlertController, animated: true)
        }
        
    }
    
    @objc(mailComposeController:didFinishWithResult:error:)
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult,error: Error?) {
            controller.dismiss(animated: true)
        }
    
}

extension OrganizationPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEventsCollectionViewCell", for: indexPath) as! UpcomingEventsCollectionViewCell
        cell.configure(with: self.eventImages[indexPath.row])
        return cell
    }
}

extension OrganizationPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension OrganizationPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
