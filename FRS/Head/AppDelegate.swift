//
//  AppDelegate.swift
//  FRS
//
//  Created by Naval Hasan on 29/04/19.
//  Copyright © 2019 infomatix. All rights reserved.
//

import UIKit
import CoreData
// import Firebase
// import FacebookCore
//import MFSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      //  FirebaseApp.configure()
     //   SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        //////////////////////////////////////////////////////////////////
        
        // PaymentGateway setup
  //  MFSettings.shared.configure(token:"DzIMcC-MT1fHttC7Ej6xpRt7MHmgLOrbquMzv5Rue7YfTkTV59MdUSwL-GjSK4tw0pnKoxbTliCL6qoL-ST5NvgiCF-RTwyxmMrItyPuM4mPUZMKFTDYVq6Iz_16oMCWX2kZAQPv6gwJrxbLi77iJ9_YpEnNvOlL78xrY7QC3bMnJkBUdj-jrj3AcCyJi63X_S5dPLzFw8GAT0xDcKUMJDMWC4LuLLP4B0mBmv1DzdHr5WNiTErDNqKx-ED33wLjt7MKhqTcHXF08WPD2lkyGVrsoJrL3JL1Qr9RiBR_PSIqe-veiThff2hJQL1qUElNt7qMiAtLPWqH0kjAm6CKlbIKXRz2kWgSpBL7kKar-4Ua3NmENao-Kc8NnIsMESdcjGmDXvR4enYXLHUrCA4zZ0hkD71GSKcdHkn0jBsgT2fwu7OTeFc-udE8hnBHiNyixoXSMDjTzGL2UV0t9qBP9bcFBNRaFdRabTHDo-jCgV8430Ur9Hqu3_9JAp6CfzbbcZsnTA3T0clbfXNUbAHUDmdckws9sqa1oWeARGYVb-6sVqqgFTz3xUrAvOgPX-VNBaSt2oWauokfTyDBbiv5eXLOBawO2KiwKJNc4rcByMYp7twYlIgnKGTXh8a5_-Ny-ovx1cX7YB99Rhd-8HUl1kHXcvreEWjEJyWq_memGxBOQNofej_dZApm7EkuJEnCMxbKWw", baseURL: "https://api.myfatoorah.com")
        
        // paymentGateway test details
        
   //     MFSettings.shared.configure(token: "7Fs7eBv21F5xAocdPvvJ-sCqEyNHq4cygJrQUFvFiWEexBUPs4AkeLQxH4pzsUrY3Rays7GVA6SojFCz2DMLXSJVqk8NG-plK-cZJetwWjgwLPub_9tQQohWLgJ0q2invJ5C5Imt2ket_-JAlBYLLcnqp_WmOfZkBEWuURsBVirpNQecvpedgeCx4VaFae4qWDI_uKRV1829KCBEH84u6LYUxh8W_BYqkzXJYt99OlHTXHegd91PLT-tawBwuIly46nwbAs5Nt7HFOozxkyPp8BW9URlQW1fE4R_40BXzEuVkzK3WAOdpR92IkV94K_rDZCPltGSvWXtqJbnCpUB6iUIn1V-Ki15FAwh_nsfSmt_NQZ3rQuvyQ9B3yLCQ1ZO_MGSYDYVO26dyXbElspKxQwuNRot9hi3FIbXylV3iN40-nCPH4YQzKjo5p_fuaKhvRh7H8oFjRXtPtLQQUIDxk-jMbOp7gXIsdz02DrCfQIihT4evZuWA6YShl6g8fnAqCy8qRBf_eLDnA9w-nBh4Bq53b1kdhnExz0CMyUjQ43UO3uhMkBomJTXbmfAAHP8dZZao6W8a34OktNQmPTbOHXrtxf6DS-oKOu3l79uX_ihbL8ELT40VjIW3MJeZ_-auCPOjpE3Ax4dzUkSDLCljitmzMagH2X8jN8-AYLl46KcfkBV", baseURL: "https://apitest.myfatoorah.com")
        
        
        //////////////////////////////////////////////////////////////////
        
   //     let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if UserDefaults.standard.bool(forKey: "loginStatus") == true{
//            
//            
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            
//            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//            let viewController = storyboard.instantiateViewController(withIdentifier: "Dashboard") as! Dashboard
//            let navigationController = UINavigationController.init(rootViewController: viewController)
//            navigationController.navigationBar.isHidden = true
//            self.window?.rootViewController = navigationController
//            
//            self.window?.makeKeyAndVisible()
//            
//        }
//        else{
//            
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            
//            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//            let viewController = storyboard.instantiateViewController(withIdentifier: "SignIn") as! SignIn
//            let navigationController = UINavigationController.init(rootViewController: viewController)
//            navigationController.navigationBar.isHidden = true
//            self.window?.rootViewController = navigationController
//            
//            self.window?.makeKeyAndVisible()
//        }
        
        
        
        return true
    }

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification notification: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        if Auth.auth().canHandleNotification(notification) {
//            completionHandler(.noData)
//            return
//        }
        // This notification is not auth related, developer should handle it.
   //     handleNotification(notification)
    }
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        return SDKApplicationDelegate.shared.application(app, open: url, options: options)
//    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "FRS")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


