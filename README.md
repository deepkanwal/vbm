## Videogame Backlog Manager

![VBM icon](http://i.imgur.com/sKLTk5W.png)

## Overview


Videogame Backlog Manager (VBM) is a simple app for iOS to help to manage your video game backlog and collection. You can search for games, add them to your library, and specify information such as progress, rating and notes. Using this information, VBM provides a simple way to keep track of your now playing list, your backlog and your library. In addition, you can also share your game lists via email. Backing up and restoring your games list is also possible through Dropbox integration. VBM uses the [GiantBomb API](http://www.giantbomb.com/api/) for game data.

VBM is available on the app store: <https://itunes.apple.com/app/videogame-backlog-manager/id721103739>

## Project state

I build VBM in the summer of 2013 as a way to get familiar with CoreData and iOS development in general. There are several cases where the code is not consistent with iOS best  practices. For instance, the entire app is built using one storyboard with no Auto Layout. I've also abused pound defines. Lastly, the MVC structure of the project isn't great. 

I actively updated the app for about year after launch but since I can no longer devote time to this project, I've decided to put the source on GitHub.

## Running the project


If you want to run this app, you will need to get a [GiantBomb API key](http://www.giantbomb.com/api/) and replace `#define NW_GB_API_KEY @"abc"` with the actual key. If you want to test Dropbox functionality you will need to get a [Dropbox developer account](https://www.dropbox.com/developers) and replace the following Dropbox keys:

	#define kDB_APP_KEY         @"abc"
	#define kDB_APP_SECRET      @"abc"

The app uses the [Dropbox Core SDK](https://www.dropbox.com/developers/core/sdks/ios). There are other keys in the app (Crashlytics and Google Analytics) that you likely won't need to worry about.

## Screenshots

![Screenshots](http://i.imgur.com/ETcqeGP.png)

## Privacy Policy

VBM uses [Google Analytics](http://www.google.ca/analytics/) to collect traffic data. This includes data such as user interactions within the app, devices used and location (granularity is limited to city). The data is not personally identifiable. VBM uses  Google Analytics purely to determine the usage of the different areas of the app. This will allow me to determine which areas of the app I should target for future updates. [Crashlytics](https://crashlytics.com/) is also used to to send back logs in the event of a crash. This includes information about the device the crash occured on (ie. iOS version, orientation, system usage). This information is used to allow me to respond to crashes as they happen. 

Last updated: Oct 6, 2013
