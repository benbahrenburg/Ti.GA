<h1>Ti.GA</h1>

A Google Analytics module that provides just what you need, in a consistent way.

This module was developed as a result of the frustration in chasing Google's changing API between SDK versions. Since most developers only care about a few features of the SDK that is what this module provides.

<h2>Downloads</h2>
Download the compiled modules at:

* [Android](https://github.com/benbahrenburg/Ti.GA/tree/master/Android/dist)
* [iOS](https://github.com/benbahrenburg/Ti.GA/tree/master/iphone/dist)

<h2>Source</h2>
Looking for the source? Check out the following:

* [Android](https://github.com/benbahrenburg/Ti.GA/tree/master/Android/src/ti/ga)
* [iOS](https://github.com/benbahrenburg/Ti.GA/tree/master/iphone)

<h2>How to...</h2>

<h4>Add to your project</h4>
You add the Ti.GA module into your project using the require keyword as shown below.

~~~
var ga = require('ti.ga');
~~~

<h4>Module Level Options</h4>

<b>Enable Trace</b>
You can enable or disable trace by calling ga.setDebug.  Provide true to enable or false to disable this option.

The following shows how to enable this feature
~~~
ga.setDebug(true);
~~~

<b>OptOut</b>
Google Analytics provides the ability to opt out of collecting information.  By default you are opt'ed into collecting information.

The following is an example on how to optout of collecting information:
~~~
ga.setOptOut(false);
~~~

If you have at one point opt'ed out you need to explicitly opt back in.  Below is an example of opt'ing into collecting information:
~~~
ga.setOptOut(true);
~~~

<b>setDispatchInterval</b>
The dispatch interval is how often in seconds that Google Analytics information should be submitted to Google.

The following show how to set the dispatch interval to 15 seconds.
~~~
ga.setDispatchInterval(15);
~~~

<b>setTrackUncaughtExceptions</b>
On iOS you can set use the setTrackUncaughtExceptions to track unhandled exceptions.

The following is an example on how to enable this feature.
~~~
ga.setTrackUncaughtExceptions();
~~~

<b>Dispatch</b>
The dispatch method submits data to Google Analytics.  Google Analytics will automatically do this for your, but you can "force" this programmatically.  If you are going to use this it should only be done while your application is not active and has a network connection.  

~~~
ga.dispatch();
~~~

<h4>Creating a tracker</h4>
~~~
var tracker = ga.createTracker({
   trackingId:'YOUR GOOGLE ANALYTICS TRACKER ID',
   useSecure:true,
   debug:true 
});
~~~

<h4>Adding User ID</h4>

If you want to associate user IDs with your analytics data, you'll first need to [create a view with User ID enabled](https://support.google.com/analytics/answer/3123666).

Then, when a user logs in, pass a unique identifier for that user with the `setUserID` method on the tracker. You only need to set this once, and all hits for the session from then on will be attributed to that ID.

~~~
tracker.setUserID('my-user-id');
~~~

<h4>Adding Screen Viewed</h4>

More coming... here is an example for now

~~~
tracker.addScreenView('my-cool-view2');
~~~

<h4>Adding Timing</h4>

More coming... here is an example for now

~~~
    tracker.addTiming({
        category:"myCategory-Timing",
        label:"myLabel",
        name:"myName",
        time:1
    });
~~~

<h4>Adding Event</h4>

More coming... here is an example for now

~~~
    tracker.addEvent({
        category:"myCategory-Event",
        action:"myAction",
        label:"myLabel",
        value:1
    });  
~~~

<h4>Adding Social Network</h4>

More coming... here is an example for now

~~~
    tracker.addSocialNetwork({
        network:"facebook",
        action:"myAcount",
        target:"myTarget"
    });  
~~~

<h4>Adding Exception</h4>

More coming... here is an example for now

~~~
    tracker.addException({
        description:"my error description",
        fatal:false
    });  
~~~

<h2>Contributors</h2>

Thank you to all of the [contributors](https://github.com/benbahrenburg/Ti.GA/graphs/contributors).

A special thank you to [Mauro Piccotti](https://github.com/nonno) for helping to address Google Play conflicts

<h2>Licensing & Support</h2>

This project is licensed under the OSI approved Apache Public License (version 2). For details please see the license associated with each project.

Developed by [Ben Bahrenburg](http://bahrenburgs.com) available on twitter [@bencoding](http://twitter.com/benCoding)
