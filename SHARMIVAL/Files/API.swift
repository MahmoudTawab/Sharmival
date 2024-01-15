//
//  API.swift
//  SHARMIVAL (iOS)
//
//  Created by Emoji Technology on 05/12/2021.
//


import FirebaseFirestore

    let defaults = UserDefaults.standard

    func LodBaseUrl() {
    Firestore.firestore().collection("API").document("IOS").addSnapshotListener { (querySnapshot, err) in
    if let err = err {
    DispatchQueue.main.async {
    defaults.set("https://sharmivalapi01.azurewebsites.net/", forKey: "API")
    defaults.set("https://sharmivalapi01.azurewebsites.net/", forKey: "Url")
    defaults.set("201003990090", forKey: "WhatsApp")
    print(err.localizedDescription)
    }
    return
    }
        
//    guard let data = querySnapshot?.data() else {
//    DispatchQueue.main.async {
    defaults.set("https://sharmivalapi01.azurewebsites.net/", forKey: "API")
    defaults.set("https://sharmivalapi01.azurewebsites.net/", forKey: "Url")
    defaults.set("201003990090", forKey: "WhatsApp")
//    }
//    return
//    }
//    DispatchQueue.main.async {
//    let DebugBase = data["DebugBaseUrl"] as? String
//    let ReleaseBase = data["ReleaseBaseUrl"] as? String
//    let WhatsApp = data["WhatsAppNumber"] as? String
//
//    defaults.set(DebugBase, forKey: "API")
//    defaults.set(ReleaseBase, forKey: "Url")
//    defaults.set(WhatsApp, forKey: "WhatsApp")
//    }
    }
    }


    ///
///
    var GUID = "00000000-0000-0000-0000-000000000000"
///

    let ApiAddDevice = "AddDevice"

    let ApiLogin = "Login"

    let ApiSignUp = "SignUp"

    let GetMainScreen = "GetMainScreen"

    let ApiGetLanguage = "GetLanguage"

    let GetProfile = "GetProfile"

    let UpdateImageProfile = "UpdateImageProfile"

    let ApiUpdateProfile = "UpdateProfile"

    let ApiGetNotification = "GetNotification"

    let ApiReadNotification = "ReadNotification"

    let ApiDeleteNotification = "DeleteNotification"

    let GetMapPlaces = "GetMapPlaces"

    let GetFAQS = "GetFAQS"

    let GetGallery = "GetGallery"

    let ApiGetProgram = "GetProgram"

    let GetAllDaysEvents = "GetAllDaysEvents"

    let GetUpcomingEvents = "GetUpcomingEvents"

    let GetSetting = "GetSetting"

    let UpdateSetting = "UpdateSetting"

    let GetDayEvents = "GetDayEvents"

    let AddToFav = "AddToFav"

    let UpdateLanguage = "UpdateLanguage"

    let GetAlbumDetails = "GetAlbumDetails"
