# FlickrSwiftUI - Image Gallery on SwiftUI

 An Image Gallery that uses Flickr public image feed as its data source.
 This is a demo app where you can see that how you can to use Flickr service api to get and show etc..  www.flickr.com/services/api/
 
**This app has been in written in SwiftUI 3.0. It requires XCode 13.4 on the machine and ios 15.5 on the device to run. **


#### Explicit requirements:  

1. As a user (of the application) I can see publicly shared photos on Flickr
2. As a user I can see the details of Photos
3. As a user I can log in and stay until I get out


### 1.  Architecture

This app has deigned using Model-View-ViewModel (MVVM) pattern to provide a separation of concerns between them. It is also useful for maintainability and it also avoids the Massive-View controllers problem.

Typically the project structure has the followings:  
* ***Constants*** – The constant values for the application
* ***Models*** – The data model to represent an entity. eg. FlickrPhoto
* ***Services*** – The core of the app that talks to the backend side via network calls
* ***Utilities*** – The model representing the data necessary for the view to display itself; but it’s also responsible for gathering, interpreting, and transforming that data by communicating with services layer  
* ***UI/View/Components*** – The UI Elements which are contained within a View Controler and interact with UI. eg. Table View Cells


### 2.  Backend Infrastructure

The backend of the project is Flickr API. The public feed of the API is accessed with an API Key.

The heart of this app is in the AsyncImage which downloads Photos from Flickr asynchronously. As Images are downloaded, they are added to the Image Cache, to avoid downloading an Image every time a reusable cell comes into view.


### 3. User Interface Design

The app is supported in portrait mode only for all device families - iPhone SE(1,2,3), 6s, 6s Plus, 7, 7 Plus, 8, 8 Plus, X, XR, XS, XS Max, 11, 11 Pro, 11 Pro Max, 12 mini, 12, 12 Pro, 12 Pro Max, 13 mini, 13, 13 Pro, 13 Pro Max, iPad, iPad mini, iPad Pro. The user interface is adaptive across all these devices.


Update README.md


