<h1>Ti.GA</h1>

Ti.GA allows you to use the Google Analytics SDKs in your Titanium projects.  The GATools CommonJS module provides a convenient set of JavaScript wrappers allowing you to drop 

<h2>Google Analytics Setup</h2>
Before you can use this module, you need a Google Analytics key.  You can get one [here](http://www.google.com/analytics).

<h2>Before you start</h2>
* These are iOS and Android native modules designed to work with Titanium SDK 3.1.3.GA
* Before using this module you first need to install the package. If you need instructions on how to install a 3rd party module please read this installation guide.

<h2>Download the compiled release</h2>

Download the platform you wish to use:

* [iOS Dist](https://github.com/benbahrenburg/Ti.GA/tree/master/iOS/dist)
* [Android Dist] (https://github.com/benbahrenburg/Ti.GA/tree/master/Android/dist)
* [GATools] (https://github.com/benbahrenburg/Ti.GA/tree/master/GATools)

<h2>Building from source?</h2>

If you are building from source you will need to do the following:

Import the project into Xcode:

* Modify the titanium.xcconfig file with the path to your Titanium installation

Import the project into Eclipse:

* Update the .classpath
* Update the build properties

<h2>Setup</h2>

* Download the latest release from the releases folder ( or you can build it yourself )
* Install the ti.sq module. If you need help here is a "How To" [guide](https://wiki.appcelerator.org/display/guides/Configuring+Apps+to+Use+Modules). 
* You can now use the module via the commonJS require method, example shown below.

<h2>Importing the module using require</h2>
<pre><code>
var ga = require('ti.ga');
</code></pre>

<h2>Module Methods</h2>

<b>Work in process</b>

<h2>Module Properties</h2>

The v3 version of the Google Analytics SDK works using a series of string constants. A full list of the module properties is available [here](https://github.com/benbahrenburg/Ti.GA/blob/master/Documentation/Properties.md).

<h2>Tracker Methods</h2>

<b>Work in process</b>

<h2>FAQ</h2>

<h4>How do I handle sessions on Android?</h4>
Android doesn't have an application level resume or pause events.  You can handle this on each activity, by hooking the window activity, read more in the [documentation](http://docs.appcelerator.com/titanium/latest/#!/api/Titanium.Android.Activity). Or you can use a timer like the GATools module does.  This basically will timeout and send the session a specific number of seconds after no activity is reported. 

<h4>My values are not appearing on the Google Analytics Dashboard</h4>
This could be for several reasons.  Please check your setup some common reasons are below.

* Did you provide the proper Google Analytics Key?
* Did you call startSession?
* Did you add any session events or screens?
* Did you call dispatch?
* Did you wait awhile, it can take minutes to hours for data to display in the Google Analytics dashboard.  

<h4>I want to do something that there isn't a method for. What do I do?</h4>
Please review the SDK documentation on [http://www.google.com/analytics](http://www.google.com/analytics).  Using the approperate Properties or String values and the tracker's proxy method you should be able to access most of the native sdk functionality.  

<h2>Learn More</h2>

<h3>Examples</h3>
Please check the module's example folder or 


* [iOS](https://github.com/benbahrenburg/Ti.SQ/tree/master/iOS/example) 
* [Android](https://github.com/benbahrenburg/Ti.SQ/tree/master/Android/Module/example)

for samples on how to use this project.

<h3>Twitter</h3>

Please consider following the [@benCoding Twitter](http://www.twitter.com/benCoding) for updates 
and more about Titanium.

<h3>Blog</h3>

For module updates, Titanium tutorials and more please check out my blog at [benCoding.Com](http://benCoding.com).
