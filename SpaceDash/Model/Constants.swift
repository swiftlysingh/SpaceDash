//
//  Constants.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 26/07/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct Constants {
    
    struct NetworkManager {
        static let baseURL = "https://api.spacexdata.com/v3/"
        static let upcomingLaunchURL = "launches/Upcoming"
        static let newURL = "https://spaceflightnewsapi.net/api/v2/articles"
    }
    
    struct  Colors {
        static let DashCream = "DashCream"
        static let DashBlack = "DashBlack"
        static let DashGray = "DashGray"
    }
    
    struct Images {
        static let stockImage = "stockImage"
    }
    
    
    struct Font{
        static let lora = "Lora"
        static let playFairDisplay = "PlayfairDisplay"
        public enum FontType: String {
            case semibold = "-SemiBold"
            case regular = "-Regular"
            case medium = "-Medium"
            case bold = "-Bold"
        }
    }
    
    
    struct SegueManager {
        static let detailViewSegue = "DetailView"
        
        struct SenderValues {
            static let rocket = "rockets"
            static let launchSite = "launchpads"
            static let landpads = "landpads"
            static let capsules = "capsules"
            static let ships = "ships"
            static let launches = "launches"
            static let news = "news"
        }
    }
    
    struct DefaultArgs {
        static let launchSite = "Launch Site Not Declared"
        static let noData = "Not Available"
    }
    
    struct HomeView{
        let upcomingLaunch: UpcomingLaunchModel
        
        lazy var payloadAndType = "\(upcomingLaunch.decodedData?.rocket.second_stage.payloads[0].payload_id ?? Constants.DefaultArgs.noData ), \(upcomingLaunch.decodedData?.rocket.second_stage.payloads[0].payload_type ?? Constants.DefaultArgs.noData)"
        
        lazy var launchSite = self.upcomingLaunch.decodedData?.launch_site.site_name_long ?? Constants.DefaultArgs.launchSite
        
        lazy var rocket = upcomingLaunch.decodedData?.rocket.rocket_name ?? "Falcon 9"
    }
    
    struct DetailsView {
        static let nibName = "DetailsTableViewCell"
        static let reuseId = "cell"
    }
    
    struct AboutView {
        static let licenseURLString = "https://github.com/pushpinderpalsingh/SpaceDash/blob/master/LICENSE"
        static let privacyURLString = "https://pushpinderpalsingh.github.io/SpaceDash/policy.html"
        static let alertMessage = "Unable to open due to some reasons please check back later"
        static let okButtonTitle = "Ok"
    }
    
    struct NewCell {
        static let reuseId = "NewsCell"
        static let title = "U.S. Stocks Post Biggest Monthly Gains Since April"
        static let description = "U.S. stocks wavered with the S&P 500 slipping, but the benchmark still finished August with a 7% advance marked by consistent daily gains.U.S. stocks wavered with the S&P 500 slipping, but the benchmark still finished August with a 7% advance marked by consistent daily gains.U.S. stocks wavered with the S&P 500 slipping, but the benchmark still finished August with a 7% advance marked by consistent daily gains."
    }
    
    
}
