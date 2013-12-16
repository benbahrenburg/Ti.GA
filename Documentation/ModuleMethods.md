<h1>Ti.GA</h1>

The below covers methods available off the root of the module.

<h2>Before getting started</h2>

The below assume the following require method is already created.

<pre><code>
var ga = require('ti.ga');
</code></pre>


<h2>Methods</h2>

<h3>debug</h3>
You can set the debug property on the root module to enabled both VERBOSE logging by Google Analytics and DEBUG logging in the Titanium module.

<pre><code>
Ti.API.info('Enabled Debug');
ga.debug = true;
Ti.API.info('Is debug enabled? ' + ga.debug);

Ti.API.info('Now disable Debug');
ga.debug = false;
Ti.API.info('Is debug enabled? ' + ga.debug);
</code></pre>

<h3>optOut</h3>
You can enable an app-level opt out flag that will disable Google Analytics across the entire app. Note that you will need to this flag must be set each time the app starts up and will default to false.

<pre><code>
Ti.API.info('You can opt out by like this');
ga.optOut = true;
Ti.API.info('What is our status? ' + ga.optOut);

Ti.API.info("Let's opt back in");
ga.optOut = false;
Ti.API.info('What is our status? ' + ga.optOut);
</code></pre>


<h3>createTracker</h3>
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

<h3>dispatchInterval</h3>
By default, data is dispatched from the Google Analytics SDK for Android every 30 minutes.  You can adjust this by using the <b>dispatchInterval</b> method.  This takes a value second whichs which will be used instead of the default dispatch value.  If you provide a value less than one, you will disable periodic dispatching.

<pre><code>

Ti.API.info('dispatch every 15 seconds');
ga.dispatchInterval(15);

Ti.API.info('Disable periodic dispatching by sending 0');
ga.dispatchInterval(0);
</code></pre>

<h3>dispatch</h3>
To manually dispatch hits, for example when you know the device radio is already being used to send other data. To do this you call the <b>dispatch</b> method as shown below.

<pre><code>

Ti.API.info('manually call dispatch');
ga.dispatch();

</code></pre>


<h3>enableTrackUncaughtExceptions</h3>
Uncaught exceptions represent instances where your app encountered unexpected conditions at runtime and are often fatal, causing the app to crash. Uncaught exceptions can be sent to Google Analytics automatically by setting the <b>enableTrackUncaughtExceptions</b> method.  This will configure your app to use an available tracker to submit your crash information automatically.  Please note you will need at least one tracker available for this this to be set.

<b>Important:</b> once set you cannot disable this until the module is unloaded and created again.

<pre><code>

Ti.API.info("enable unhandled exception tracking");
ga.enableTrackUncaughtExceptions();

</code></pre>

<h3>isTrackUncaughtExceptionsActive</h3>
You can check if <b>enableTrackUncaughtExceptions</b> has been set for your app setting by calling the <b>isTrackUncaughtExceptionsActive</b> method.

<pre><code>

Ti.API.info("Is unhandled exception tracking set? " + ga.isTrackUncaughtExceptionsActive());

</code></pre>