# SpaceDash iOS Architecture 🛠
This document aims to provide a deeper insight into the current architecture for SpaceDash. The guide explains in detail how the app is structured and built, as well as includes detailed descriptions of the design pattern and current logic.  

SpaceDash is an app that provides information on launches and vehicles of SpaceX. The app uses API requests to retrieve data from the SpaceX API. The MVC design pattern means that the app can be structured logically. 

> New contributors should study the documentation in able to support further builds of SpaceDash. 

# Core Architecture 📱

<span>
<img src="Assets/MVC-IOS-architecture.png"/>
</span>

## What Is the MVC Design Pattern
**MVC design pattern**: a design pattern for building apps using object orientated programming (OOP). It helps structuring complex apps, MVC stands for:
* **Model:** manages data and structures it
* **View:** what is seen on a screen, such as UI elements
* **Controller:** handles communication between model and view

### Model
The model layer contains an app’s data, as such within SpaceDash this encompasses:
* **Networking:** the network manager struct handles all network communication for SpaceDash. The struct handles all communication for SpaceDash with the SpaceX API. The network manager struct also handles errors. Contributors looking to expand upon networking should be comfortable with protocols, delegates and parsing JSON
* **Parsing (JSON):** parsing is the analysis and interpretation of data. Swift has a built in method of handling JSON using the Codable protocol. Parsing is handled through the network manager and uses an instance of `JSONDecoder()`, which in turn calls the `decode()` method to convert into objects e.g. Rocket objects 
* **Persistence:** once data has been obtained this is then persisted and stored through Realm [Work-in-progress]

**Core files:** NetworkManager, JSONDecoders and DataModels

### View
The view layer handles how an app looks. Any code contained here is for visual aspects of SpaceDash. This layer contains the following:
* **Animation extensions:** files related to animations, such as JSON files for the Lottie framework
* **View extensions:** UIView subclasses supporting any of the app’s design
* **Storyboards:** visual UI of the app. Contributors should create new storyboards for additional screens

**Core files:** Animations, Storyboards and TableViewCell

### Controller
The controller layer handles any communication between a user and the view, the controller also helps manipulate the model. The controller is the input mechanism of the UI, a view cannot work without the corresponding controller. SpaceDash controllers:
* **ViewControllers:** individual files for the screens (view). When creating or adding new screens to SpaceDash please ensure that the naming conventions follow a logical approach. As such, the file name of the ViewController should represent the screen that is being added
* **UIView:** code to handle how data is presented to users when viewing the app. These are specific to the view

**Core files:** ViewControllers and UIView 

## [](https://github.com/pushpinderpalsingh/SpaceDash#resources)Supporting Files
* [README.md](https://github.com/pushpinderpalsingh/SpaceDash/blob/develop/README.md)
* [Contributing.md](https://github.com/pushpinderpalsingh/SpaceDash/blob/develop/Contributing.md)
* [Contributors.md](https://github.com/pushpinderpalsingh/SpaceDash/blob/develop/Contributors.md)
* [SpaceX API](https://github.com/r-spacex/SpaceX-API)

#### [Join the conversation on Slack.](https://communityinviter.com/apps/spacedashworkspace/spacedash)
