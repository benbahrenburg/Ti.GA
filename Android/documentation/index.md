# Google Analytics Module

## Description
Provides access to the Google Analytics Mobile SDK.

## Accessing the Module
To access this module from JavaScript, you would do the following:

	var GoogleAnalytics = require("ti.googleanalytics");

The variable is a reference to the Module object.	


## How to Learn More

This module conforms very closely to Google's Analytics SDKs for iOS and Android. As such, the documentation for these SDKs will help you
understand how to use this module, and how to collect the analytics data that you want.

[Android SDK Guide](https://developers.google.com/analytics/devguides/collection/android/v3/)
[iOS SDK Guide](https://developers.google.com/analytics/devguides/collection/ios/v3/)


## A Warning About Tracking IDs
Google Analytics Website Tracking IDs will NOT work with this module (because they don't work with the underlying Google SDK).
Instead, you must generate new App specific Tracking IDs:
 - Go to analytics.google.com.
 - Sign in.
 - Go to Admin > Accounts > Create New Account.
 - Choose "App" beside "What would you like to track?"
 - Create the account, and get the tracking ID.
 

## Reference

### [Tracker](tracker.html) getTracker([String trackingName, ] String trackingId)
Gets a [tracker](tracker.html), based on the provided ID and optional name.

### [Tracker](tracker.html) getDefaultTracker()
Returns the default [tracker](tracker.html). This is the first [tracker](tracker.html) requested by the "getTracker" method during the 
current app run.

### void setDefaultTracker([Tracker](tracker.html) tracker)
Specifies which [tracker](tracker.html) should be returned by the "getDefaultTracker" method.

### void closeTracker(String trackingId)
Closes a [tracker](tracker.html), releasing any related resources it was using.


## Properties

### bool dryRun
Use this to test your's app's interactions with Google Analytics. No data will be sent to Google.

### bool optOut
If true, the user has decided to not let you collect analytics data. This property is NOT persistent, so you must set it each time your app
loads.

### [MapBuilder](mapbuilder.html) getMapBuilder()
Gets a reference to the [map builder](mapbuilder.html), which helps you send data to Google.

### [Fields](fields.html) getFields()
Gets a reference to the [field constants](fields.html), which you will use when sending data to Google.


## Usage
See example.


## Module History
View the [change log](changelog.html) for this module.


## Author
Dawson Toth


## Feedback and Support
Please direct all questions, feedback, and concerns to [info@appcelerator.com](mailto:info@appcelerator.com?subject=Android%20Google%20Analytics%20Module).


## License
Copyright(c) 2010-2013 by Appcelerator, Inc. All Rights Reserved. Please see the LICENSE file included in the distribution for further details.