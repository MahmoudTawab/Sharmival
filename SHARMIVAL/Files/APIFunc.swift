//
//  APIFunc.swift
//  APIFunc
//
//  Created by Emoji Technology on 27/09/2021.
//  Copyright © 2021 Mahmoud Tawab. All rights reserved.
//


import UIKit
import SDWebImage
import FirebaseStorage

   func PostAPI(timeout:Double = 40,api:String ,token:String?
                 , parameters:Any
                 ,string: @escaping ((String) -> Void)
                 , DictionaryData: @escaping (([String: Any]) -> Void)
                 , ArrayOfDictionary: @escaping (([[String: Any]]) -> Void)
                 , Err: @escaping ((String) -> Void)) {
        
        
    guard let Url = URL(string:api) else {return}
    var request = URLRequest(url: Url)
    request.httpMethod = "POST"
    request.timeoutInterval = timeout
    timeInterval = timeout + 5
      

    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")

    if let Token = token {
    request.setValue( "Bearer \(Token)", forHTTPHeaderField: "Authorization")
    }

    do {
    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    } catch let error {
    Err(error.localizedDescription)
    return
    }

    URLSession.shared.dataTask(with: request) { data, response, error in

    guard let data = data else {
    if let error = error {
    DispatchQueue.main.async {
    Err(StatusCodes(-1001, "\n" + error.localizedDescription))
    }
    }
    return
    }

    do {
    guard let response = response as? HTTPURLResponse else {return}
    if response.statusCode != 200 {
    if response.statusCode != 406 {
    DispatchQueue.main.async {
    Err(StatusCodes(response.statusCode))
    }
    }else{
    if response.statusCode == 406 {
    if let Array = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
    let Messag = Array["Messag"] as? String ?? "Sorry, unable to connect to the server"
    DispatchQueue.main.async {
    Err(StatusCodes(406, "ERROR MESSAG".localizable + "\n" + Messag))
    }
    }
    }
    }
    return
    }else{
    DispatchQueue.main.async {
    string("Successful")
    }
    }
        
//  let str = String(decoding: data, as: UTF8.self)
    do {
    let decodedPerson = try JSONDecoder().decode(String.self, from: data)
    
    if let data = decodedPerson.data(using: .utf8) {
    if let array = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
    DispatchQueue.main.async {
    DictionaryData(array)
    }
    }
     
    if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
    DispatchQueue.main.async {
    ArrayOfDictionary(dictionary)
    }
    }
      
    }
    }catch{
    if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
    DispatchQueue.main.async {
    ArrayOfDictionary(dictionary)
    }
    }
        
    if let array = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
    DispatchQueue.main.async {
    DictionaryData(array)
    }
    }
    }
    }catch{
    return
    }
    }.resume()
    }



  func StatusCodes(_ Status:Int ,_ Messag:String = "") -> String {

    switch Status {

        ///
    
    case 204:
    return "No Content".localizable
        
    case 304:
    return "NotModified".localizable
        
       ///
    case 400:
    return "Bad Request".localizable
       
       ///
    case 401:
    UpDateDevice()
    return "Unauthorized".localizable
       
    ///
    case 404:
    return "Not Found".localizable
        
    case 405:
    return "NotAllowed".localizable
    
    ///
    case 406:
    return Messag
      
    case 500:
    return "internalServerError".localizable
        
    case 600:
    return "Email is used".localizable
        
    case 601:
    return "Phone Number is used".localizable
        
    case 602:
    return "User already exists".localizable
        
    case 604:
    return "You have reached the invitation limit".localizable
        
    ///
    case -1001:
    return Messag
       
    default:
    break
    }

    return ""
    }


   func ShowMessageAlert(_ IconTitle:String ,_ Title:String ,_ Message:String,_ DoneisHidden:Bool ,_ selector: @escaping () -> Void ,_ ButtonText : String = "Try Again".localizable) {
        
    if var topController = UIApplication.shared.keyWindow?.rootViewController  {
    while let presentedViewController = topController.presentedViewController {
    topController = presentedViewController
    }
    
    let Controller = PopUpCenterView()
    Controller.MessageTitle = Title
    Controller.MessageDetails = Message
    Controller.ImageIcon = IconTitle
    Controller.RightButtonText = ButtonText
    Controller.StackIsHidden = false
    Controller.RightButton.isHidden = DoneisHidden

    Controller.RightButton.addAction(for: .touchUpInside) { (button) in
    selector()
    }
    
    Controller.modalPresentationStyle = .overFullScreen
    Controller.modalTransitionStyle = .crossDissolve
    topController.present(Controller, animated: true, completion: nil)
    }
    }

    func UpDateDevice() {
    let url = defaults.string(forKey: "API") ?? "https://Sharmival.azurewebsites.net/"
    let api = "\(url + ApiAddDevice)"

    let modelName = UIDevice.modelName
    let version = UIDevice.current.systemVersion
    let fireToken = defaults.string(forKey: "fireToken") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""

    let parameters:[String:Any] = ["token": "I57sMTbkmuYaILn9MxDEdb0R6rVqG2aW8EfSQNfpb1k",
                                    "appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
                                    "Platform": "I",
                                    "lang": "lang".localizable,
                                    "fireToken": fireToken,
                                    "deviceID": udid,
                                    "deviceModel": modelName,
                                    "manufacturer": "Iphone",
                                    "osVersion": version,
                                    "versionCode": "1"]

    PostAPI(timeout: 20,api: api, token: nil, parameters: parameters) { _ in
    } DictionaryData: { data in
    let _ = DeviceModel(dictionary: data)
    } ArrayOfDictionary: { _ in
    } Err: { error in
    }
   }


    func Storag(child1:String = "" ,child2:String = "",child3:String = "",child4:String = "" , image: UIImage, completionHandler: @escaping ((String) -> Void), Err: @escaping ((String) -> Void)) {
    let storage = Storage.storage().reference().child(child1).child(child2).child(child3).child(child4)
    let metaData = StorageMetadata()
    metaData.contentType = "image/jpg"
    guard let data = image.jpegData(compressionQuality: 0.75) else {return}
    storage.putData(data, metadata: metaData, completion: { (url, err) in
    if let err = err {
    Err(err.localizedDescription)
    return
    }
    storage.downloadURL {(url, err) in
    if let err = err {
    Err(err.localizedDescription)
    return
    }
    guard let add_downloadUrl = url?.absoluteString else{return}
    completionHandler(add_downloadUrl)
    }
    })
    }


 func StoragRemove(child1:String = "" ,child2:String = "",child3:String = "",child4:String = "")  {
     let storage = Storage.storage().reference().child(child1).child(child2).child(child3).child(child4)
     storage.delete(completion: { error in
     print(error ?? "")
     })
}


func StoragUpDate(child1:String = "" ,child2:String = "",child3:String = "",child4:String = "")  {
    let storage = Storage.storage().reference().child(child1).child(child2).child(child3).child(child4)
    storage.delete(completion: { error in
    print(error ?? "")
    })
}
