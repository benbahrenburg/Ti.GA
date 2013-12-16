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

<h4>debug</h4>
You can set the debug property on the root module to enabled both VERBOSE logging by Google Analytics and DEBUG logging in the Titanium module.

<pre><code>
Ti.API.info('Enabled Debug');
ga.debug = true;
Ti.API.info('Is debug enabled? ' + ga.debug);

Ti.API.info('Now disable Debug');
ga.debug = false;
Ti.API.info('Is debug enabled? ' + ga.debug);
</code></pre>

<h4>optOut</h4>
You can enable an app-level opt out flag that will disable Google Analytics across the entire app. Note that you will need to this flag must be set each time the app starts up and will default to false.

<pre><code>
Ti.API.info('You can opt out by like this');
ga.optOut = true;
Ti.API.info('What is our status? ' + ga.optOut);

Ti.API.info("Let's opt back in");
ga.optOut = false;
Ti.API.info('What is our status? ' + ga.optOut);
</code></pre>


<h4>createTracker</h4>
The <b>createTracker</b> method returns a tracker proxy which can be used to perform a majority of your analytics needs.  Please reference the "Tracker Methods" section for additional details. There are two ways to create a tracker, with or without a Google Analytics key.


<b>Creating Tracker with Key</b>

The most common way to create a tracker is with a Google Analytics key such as UA-XXXX-1.  This allows you to submit analytic information to a specific Property on the Goolge Analytisc dashboard.  Below demonstrates how to create a tracker with a Google Key.

<pre><code>
	
Ti.API.info('Create a tracker with a Google Analytics Key');
var tracker = ga.createTracker({
	ga.TRACKING_ID,"UA-XXXX-1"
});

</code></pre>

<b>Create a default Tracker</b>

A default tracker doesn't have a Google Analytics key.  This type of tracker isn't used very often as reporting is difficult.  Below shows how to create a traceker without a Google Analytics key.

<pre><code>

Ti.API.info('Create a tracker without a Google Analytics Key');
var tracker = ga.createTracker();

</code></pre>

<h4>dispatchInterval</h4>
By default, data is dispatched from the Google Analytics SDK for Android every 30 minutes.  You can adjust this by using the <b>dispatchInterval</b> method.  This takes a value second whichs which will be used instead of the default dispatch value.  If you provide a value less than one, you will disable periodic dispatching.

<pre><code>

Ti.API.info('dispatch every 15 seconds');
ga.dispatchInterval(15);

Ti.API.info('Disable periodic dispatching by sending 0');
ga.dispatchInterval(0);
</code></pre>

<h4>dispatch</h4>
To manually dispatch hits, for example when you know the device radio is already being used to send other data. To do this you call the <b>dispatch</b> method as shown below.

<pre><code>

Ti.API.info('manually call dispatch');
ga.dispatch();

</code></pre>


<h4>enableTrackUncaughtExceptions</h4>
Uncaught exceptions represent instances where your app encountered unexpected conditions at runtime and are often fatal, causing the app to crash. Uncaught exceptions can be sent to Google Analytics automatically by setting the <b>enableTrackUncaughtExceptions</b> method.  This will configure your app to use an available tracker to submit your crash information automatically.  Please note you will need at least one tracker available for this this to be set.

<b>Important:</b> once set you cannot disable this until the module is unloaded and created again.

<pre><code>

Ti.API.info("enable unhandled exception tracking");
ga.enableTrackUncaughtExceptions();

</code></pre>

<h4>isTrackUncaughtExceptionsActive</h4>
You can check if <b>enableTrackUncaughtExceptions</b> has been set for your app setting by calling the <b>isTrackUncaughtExceptionsActive</b> method.

<pre><code>

Ti.API.info("Is unhandled exception tracking set? " + ga.isTrackUncaughtExceptionsActive());

</code></pre>

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
