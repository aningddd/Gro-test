//
//  dataManager.swift
//  BackEndTest
//
//  Created by Bowen一一＂一 yang一一 on 11/6/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import UIKit
class DataManager{
    static var app: DataManager = {
        return DataManager()
    }()
    // Upload Data for Orgs

    //function for UploadEvent
    func UploadEvent(orgName: String, eventDescription: String, eventPicture: UIImage, position_x: Float, position_y: Float, eventName: String,eventYear: String ,eventMonth: String, eventDate:String, eventTime: String, eventLocationName: String){
        let storageRef = Storage.storage().reference()
        let inputPath = "orgData/\(orgName)/images/\(UUID().uuidString)"
        let imagesRef = storageRef.child(inputPath)
        let imageData = eventPicture.jpegData(compressionQuality: 0.8)
        guard imageData != nil else {
            print("No image data input in uploadOrgData!!!")
            return
        }
        let uploadTask = imagesRef.putData(imageData!, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            print("No meta data here")
            return
          }
            let db = Firestore.firestore()
            db.collection(orgName).document(eventName).setData(["eventPicPath":inputPath,
                                                       "position_x": position_x,
                                                       "position_y": position_y,
                                                       "description": eventDescription,
                                                       "eventName": eventName,
                                                       "eventLoactionName": eventLocationName,
                                                       "eventYear": eventYear,
                                                       "eventMonth":eventMonth,
                                                       "eventDate": eventDate,
                                                       "eventTime": eventTime
                                                      ])
            
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
            imagesRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
          }
        }
    }

    // Become a member of an org
    // for user's meta collection if it is started with subscribed@@@_, it is the organization they subscribe to
    // if it is email + eventName: Should be event they subscribe to
    func subscribeToOrg(orgName: String, orgEmail: String, userEmail: String){
        let db = Firestore.firestore()
        db.collection(orgEmail + "_meta").document(userEmail).setData(["Subscribe": userEmail])
        db.collection(userEmail + "_meta").document("subscribed@@@_" + orgEmail).setData(["orgName": orgName, "orgEmail": orgEmail, "recordType": "subscribedOrg", "EventName": nil])
        let docRef = db.collection(orgEmail + "_meta").document("userMeta")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                 
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
    // retrieve list of user's subscribed organization
    func retrieveSubScribed(userEmail: String, completion: @escaping ([userName_email]) -> Void){
        var userList = [userName_email]()
        let db = Firestore.firestore()
        db.collection(userEmail + "_meta").getDocuments{snapshot, error in
            if error == nil && snapshot != nil {
                for doc in snapshot!.documents {
                    if(doc["recordType"] != nil && doc["recordType"] as! String == "subscribedOrg"){
                        let curOrgData:userName_email = userName_email(userName: doc["orgName"] as! String, email: doc["orgEmail"] as! String)
                        userList.append(curOrgData)
                    }
                }
                completion(userList)
            }else{
                print("we are in error or nil")
                print(error)
                print(snapshot)
            }
        }
    }
    
    // Cancel subscription
    
    func cancelSubScription(userEmail: String, orgEmail: String){
        let db = Firestore.firestore()
        db.collection(userEmail + "_meta").document("subscribed@@@_" + orgEmail).delete(){
            err in
            if let err = err{
                print("error occur")
            }else{
                db.collection(orgEmail + "_meta").document(userEmail).delete(){
                    err in
                    
                }
            }
        }
    }
    
    
    
    // check membership of an org
    
    
    // register for event
    
    // orgnization event should consist of emaillist of people joinining this event
    
    
    func UploadUserData(email: String, orgAvatar: UIImage, orgDescription: String, type:String, userName: String){
        guard type == "orgData" || type == "userData" else {
            print("input data type wrong, only option is orgData or userData")
            return
        }
        let storageRef = Storage.storage().reference()
        let inputPath = "\(type)/\(email)/images/\(UUID().uuidString)"
        let imagesRef = storageRef.child(inputPath)
        
        let imageData = orgAvatar.jpegData(compressionQuality: 0.8)
        guard imageData != nil else {
            print("No image data input in uploadOrgData!!!")
            return
        }
        let uploadTask = imagesRef.putData(imageData!, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            print("No meta data here")
            return
          }
            let db = Firestore.firestore()
            db.collection(email + "_meta").document("userMeta").setData(["avatarURL":inputPath,
                                                       "type": type,
                                                       "description": orgDescription,
                                                               "userName": userName,
                                                                         "recordType": "metaData"
                                                      ])
            if(type == "orgData") {
                db.collection("UserName_Meta_main_keyset_Org").document(userName).setData(["email": email, "type": type, "userName": userName])
            }else{
                db.collection("UserName_Meta_main_keyset_User").document(userName).setData(["email": email ,"type": type, "userName": userName])
            }
            

            
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
            imagesRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
          }
        }
    }
    
    func retrieveUserEmail(userName: String,type:String, completion: @escaping (userName_email) -> Void){
        let db = Firestore.firestore()
        //UserName_Meta_main_keyset_Org
        
        var docRefC = db.collection("UserName_Meta_main_keyset_User")
        if(type == "orgData"){
            print("find correct")
            docRefC = db.collection("UserName_Meta_main_keyset_Org")
        }
        let docRef = docRefC.document(userName)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                completion(userName_email(userName: document["userName"] as! String, email: document["email"] as! String))
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func retrieveAllUser(type: String, completion: @escaping ([userName_email]) -> Void){
        var userList = [userName_email]()
        let db = Firestore.firestore()
        if(type == "orgData"){
            db.collection("UserName_Meta_main_keyset_Org").getDocuments{snapshot, error in
                if error == nil && snapshot != nil {
                    for doc in snapshot!.documents {
                        let curUserData:userName_email = userName_email(userName: doc["userName"] as! String, email: doc["email"] as! String)
                        userList.append(curUserData)
                    }

                    completion(userList)
                }else{
                    print("we are in error or nil")
                    print(error)
                    print(snapshot)
                }
            }
        }else{
            db.collection("UserName_Meta_main_keyset_User").getDocuments{snapshot, error in
                if error == nil && snapshot != nil {
                    for doc in snapshot!.documents {
                        let curUserData:userName_email = userName_email(userName: doc["userName"] as! String, email: doc["email"] as! String)
                        userList.append(curUserData)
                    }
                    completion(userList)
                }else{
                    print("we are in error or nil")
                    print(error)
                    print(snapshot)
                }
            }
        }
    }

    func retrieveEventData(OrgName:String, completion: @escaping ([EventData]) -> Void){
        var result_I = [EventData]()
        let stRef = Storage.storage().reference()
        let myGroup = DispatchGroup()
        self.retrieveEventPath(orgName: OrgName) {results in
            for result in results{
                var curResult = result
                myGroup.enter()
                print("we are attaching image path here")
                let fileRef = stRef.child(result.url)
                fileRef.getData(maxSize:5*1024*1024){
                    data, error in
                    print(" here is error: ", error)
                    print("here is data: ", data)
                    if error == nil && data != nil{
                        print("attached")
                        curResult.image = UIImage(data: data!)!
                        result_I.append(curResult as! EventData)
                    }else{
                        print(error)
                    }
                    myGroup.leave()
                }
            }
            myGroup.notify(queue:.main){
                completion(result_I)
            }
        }
    }
    
    func retrieveEventPath(orgName:String ,completion: @escaping ([EventData]) -> Void){
        let db = Firestore.firestore()
        
        var result = [EventData]()
//        var imagePaths = [String]()
//        var images = [UIImage]()"eventPicPath":inputPath,
//        "position_x": position_x,
//        "position_y": position_y,
//        "description": eventDescription,
//        "eventName": eventName
        db.collection(orgName).getDocuments{snapshot, error in
            if error == nil && snapshot != nil {
                for doc in snapshot!.documents {
                    let curEventData = EventData(orgName: orgName, eventName: doc["eventName"] as! String, description: doc["description"] as! String, image: UIImage(), position_x: doc["position_x"] as! Float, position_y: doc["position_y"] as! Float, url: doc["eventPicPath"] as! String, eventLocation: doc["eventLoactionName"] as! String, year: doc["eventYear"] as! String, month: doc["eventMonth"] as! String, date: doc["eventDate"] as! String, time: doc["eventTime"] as! String)
                    
                    result.append(curEventData)
                }

                completion(result)
            }else{
                print("we are in error or nil")
                print(error)
                print(snapshot)
            }
        }

    }
    
    
    
    
    func retrieveUserData(email:String, completion: @escaping ([UserData]) -> Void){
        var result_I = [UserData]()
        let stRef = Storage.storage().reference()
        let myGroup = DispatchGroup()
        self.retrieveUserPath(email:email) {results in
            for result in results{
                var curResult = result
                myGroup.enter()
                print("we are attaching image path here")
                let fileRef = stRef.child(result.url)
                fileRef.getData(maxSize:5*1024*1024){
                    data, error in
                    print(" here is error: ", error)
                    print("here is data: ", data)
                    if error == nil && data != nil{
                        print("attached")
                        curResult.avatar = UIImage(data: data!)!
                        result_I.append(curResult as! UserData)
                    }else{
                        print(error)
                    }
                    myGroup.leave()
                }
            }
            myGroup.notify(queue:.main){
                completion(result_I)
            }
        }
    }
    
    // Retrieve user path helper
    func retrieveUserPath(email:String ,completion: @escaping ([UserData]) -> Void){
        let db = Firestore.firestore()
        
        var result = [UserData]()
//        var imagePaths = [String]()
//        var images = [UIImage]()
        let userNameM = email + "_meta"
//
//        let docRef = docRefC.document(userName)
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                completion(userName_email(userName: document["userName"] as! String, email: document["email"] as! String))
//            } else {
//                print("Document does not exist")
//            }
//        }
        let docRef = db.collection(userNameM).document("userMeta")
        docRef.getDocument { (document, error) in
            if let doc = document, doc.exists {
                    let curUserData = UserData(type: doc["type"] as! String, description: doc["description"] as! String, avatar: UIImage(), userName: doc["userName"] as! String, url: doc["avatarURL"] as! String, email: email)
                        result.append(curUserData)
                        completion(result)
                    } else {
                        print("Document does not exist")
                    }
        }

    }
    
    // Upload Data for user
    
    // Upload seperate data

}

