<h1>Ti.GA</h1>

The v3 version of the Google Analytics SDK works using a series of string constants.  This allows you to set an access most parts of the SDK using the getValue and setValue methods.  You can also use the send method to send a dictionary of these constants.

<h2>Common Module Properties</h2>

<h3>TRACKING_ID</h3>
The <b>TRACKING_ID</b> property is used to set the tracking ID for the tracker object.  This ID links the Google Analytics results to your Google Analytics dashboard.  There are two ways to set this value.

Recommended: On creation
<pre><code>
var ga = require('ti.ga');
var tracker = ga.createTracker({
	ga.TRACKING_ID,"UA-XXXX-1"
});
</code></pre>


Optional : Convert a default tracker to a named tracker
<pre><code>
var ga = require('ti.ga');
var tracker = ga.createTracker();
//Add the tracker ID to the default tracker
tracker.setValue(ga.TRACKING_ID,"UA-XXXX-1");
</code></pre>

<h3>APP_NAME</h3>
Typically the <b>APP_NAME</b> property is used to set the application name in Google Analytics.  The below example demonstrates how this is done.

<pre><code>
var ga = require('ti.ga');
var tracker = ga.createTracker({
	ga.TRACKING_ID,"UA-XXXX-1"
});
//Set the GA app name to the Titanium Project Name
tracker.setValue(ga.APP_NAME,Ti.App.name);
</code></pre>

<h3>APP_VERSION</h3>
Typically the <b>APP_VERSION</b> property is used to set the application version in Google Analytics.  The below example demonstrates how this is done.

<pre><code>
var ga = require('ti.ga');
var tracker = ga.createTracker({
	ga.TRACKING_ID,"UA-XXXX-1"
});
//Set the GA app version to the Titanium Project Name
tracker.setValue(ga.APP_VERSION,Ti.App.version);
</code></pre>

<h3>APP_ID</h3>
Typically the <b>APP_ID</b> property is used to set the application ID in Google Analytics.  The below example demonstrates how this is done.

<pre><code>
var ga = require('ti.ga');
var tracker = ga.createTracker({
	ga.TRACKING_ID,"UA-XXXX-1"
});
//Set the GA app id to the Titanium Project Name
tracker.setValue(ga.APP_ID,Ti.App.id);
</code></pre>

<h3>ANONYMIZE_IP</h3>
Typically the <b>ANONYMIZE_IP</b> property is used to tell Google Analytics to anonymize the IP address of the device. This takes a boolean method as a string, so it is recommended to use the helpers to avoid cross platform conversion issues.  Below is an example on how to turn this feature on and off.

<pre><code>
var ga = require('ti.ga');
var tracker = ga.createTracker({
	ga.TRACKING_ID,"UA-XXXX-1"
});
//Turn on anonymize IP
tracker.setValue(ga.ANONYMIZE_IP,ga.HELPER_CONSTANT_TRUE);
//Turn off anonymize IP
tracker.setValue(ga.ANONYMIZE_IP,ga.HELPER_CONSTANT_FALSE);
</code></pre>

<h3>USE_SECURE</h3>
The <b>USE_SECURE</b> property is used to tell Google Analytics to use https.  Please note as of v3 of the SDK this is enabled by default.  You can also turn of http using this method.  Below is an example on how to turn this feature on and off.

<pre><code>
var ga = require('ti.ga');
var tracker = ga.createTracker({
	ga.TRACKING_ID,"UA-XXXX-1"
});
//Turn on https
tracker.setValue(ga.USE_SECURE,ga.HELPER_CONSTANT_TRUE);
//Turn off https
tracker.setValue(ga.USE_SECURE,ga.HELPER_CONSTANT_FALSE);
</code></pre>

<h3>LANGUAGE</h3>
The <b>LANGUAGE</b> property can be used to set the language of the user.  The below example demonstrates how this is done.

<pre><code>
var ga = require('ti.ga');
var tracker = ga.createTracker({
	ga.TRACKING_ID,"UA-XXXX-1"
});

tracker.setValue(ga.LANGUAGE,Ti.Locale.currentLanguage);
</code></pre>


<h2>Properties For Screen Visits</h2>
You can record screen views using the <b>send</b> method the below properties.

<h3>SCREEN_NAME</h3>
The <b>SCREEN_NAME</b> property is used with the <b>setValue</b> and <b>send</b> methods to record the visited screen.  See the example below.

<pre><code>
var ga = require('ti.ga');
var tracker = ga.createTracker({
	ga.TRACKING_ID,"UA-XXXX-1"
});

//Set the name of your screen
tracker.setValue(ga.SCREEN_NAME,"My_Screen");
//Send the value
tracker.send();

</code></pre>


<h2>Session Properties</h2>

<h3>SESSION_CONTROL</h3>
The <b>SESSION_CONTROL</b> is used to adjust the default session management of 30 minutes.

<b>Creating a new session</b>
<pre><code>
var ga = require('ti.ga');
var tracker = ga.createTracker({
	ga.TRACKING_ID,"UA-XXXX-1"
});
tracker.setValue(ga.SESSION_CONTROL,"start");

</code></pre>

<b>Ending a session</b>
<pre><code>
tracker.setValue(ga.SESSION_CONTROL,"end");

</code></pre>


<h2>Ecommerce Tracking</h2>

<h3>TRANSACTION_ID</h3>
The <b>TRANSACTION_ID</b> is used with the <b>setValue</b> to create an unique ID representing the transaction. This ID should not collide with other transaction IDs.

<h3>TRANSACTION_AFFILIATION</h3>
The <b>TRANSACTION_AFFILIATION</b> is used with the <b>setValue</b> to create an entity with which the transaction should be affiliated (e.g. a particular store).

<h3>TRANSACTION_REVENUE</h3>
The <b>TRANSACTION_REVENUE</b> is used with the <b>setValue</b> to create the total revenue of a transaction, including tax and shipping.

<h3>TRANSACTION_SHIPPING</h3>
The <b>TRANSACTION_SHIPPING</b> is used with the <b>setValue</b> to create the total cost of shipping for a transaction

<h3>TRANSACTION_TAX</h3>
The <b>TRANSACTION_TAX</b> is used with the <b>setValue</b> to create the total tax for a transaction

<h3>CURRENCY_CODE</h3>
The <b>CURRENCY_CODE</b> is used with the <b>setValue</b> to create the local currency of a transaction. Defaults to the currency of the view (profile) in which the transactions are being viewed.

<h3>ITEM_NAME</h3>
The <b>ITEM_NAME</b> is used with the <b>setValue</b> to create the name of the product.

<h3>ITEM_PRICE</h3>
The <b>ITEM_PRICE</b> is used with the <b>setValue</b> to create the price of a product.

<h3>ITEM_QUANTITY</h3>
The <b>ITEM_QUANTITY</b> is used with the <b>setValue</b> to create the quantity of a product.

<h3>ITEM_SKU</h3>
The <b>ITEM_SKU</b> is used with the <b>setValue</b> to create the SKU of a product.

<h3>ITEM_CATEGORY</h3>
The <b>ITEM_CATEGORY</b> is used with the <b>setValue</b> to create a category to which the product belongs.


<h2>Event Tracking</h2>

<h3>EVENT_CATEGORY</h3>
The <b>EVENT_CATEGORY</b> is used with the <b>setValue</b> to create the event category.

<h3>EVENT_ACTION</h3>
The <b>EVENT_ACTION</b> is used with the <b>setValue</b> to create the event action.

<h3>EVENT_LABEL</h3>
The <b>EVENT_LABEL</b> is used with the <b>setValue</b> to create the event label.

<h3>EVENT_VALUE</h3>
The <b>EVENT_VALUE</b> is used with the <b>setValue</b> to create the event value.


<h2>General Campaign & Traffic Source Attribution</h2>

<h3>CAMPAIGN_NAME</h3>
The <b>CAMPAIGN_NAME</b> is used with the <b>setValue</b> to create the Campaign name; used for keyword analysis to identify a specific product promotion or strategic campaign.

<h3>CAMPAIGN_SOURCE</h3>
The <b>CAMPAIGN_SOURCE</b> is used with the <b>setValue</b> to create the Campaign source; used to identify a search engine, newsletter, or other source.

<h3>CAMPAIGN_MEDIUM</h3>
The <b>CAMPAIGN_MEDIUM</b> is used with the <b>setValue</b> to create the Campaign medium; used to identify a medium such as email or cost-per-click (cpc).

<h3>CAMPAIGN_KEYWORD</h3>
The <b>CAMPAIGN_MEDIUM</b> is used with the <b>setValue</b> to create the Campaign term; used with paid search to supply the keywords for ads

<h3>CAMPAIGN_CONTENT</h3>
The <b>CAMPAIGN_MEDIUM</b> is used with the <b>setValue</b> to create the Campaign content; used for A/B testing and content-targeted ads to differentiate ads or links that point to the same URL

<h3>CAMPAIGN_ID</h3>
The <b>CAMPAIGN_MEDIUM</b> is used with the <b>setValue</b> to create the AdWords autotagging parameter; used to measure Google AdWords ads. This value is generated dynamically and should never be modified.


<h2>Social Interactions</h2>

<h3>SOCIAL_NETWORK</h3>
The <b>SOCIAL_NETWORK</b> is used with the <b>setValue</b> to create the social network with which the user is interacting (e.g. Facebook, Google+, Twitter, etc.).

<h3>SOCIAL_ACTION</h3>
The <b>SOCIAL_ACTION</b> is used with the <b>setValue</b> to create the social action taken (e.g. Like, Share, +1, etc.).

<h3>SOCIAL_TARGET</h3>
The <b>SOCIAL_TARGET</b> is used with the <b>setValue</b> to create the content on which the social action is being taken (i.e. a specific article or video).


<h2>User Timings</h2>

<h3>TIMING_CATEGORY</h3>
The <b>TIMING_CATEGORY</b> is used with the <b>setValue</b> to create the category of the timed event.

<h3>TIMING_VAR</h3>
The <b>TIMING_VAR</b> is used with the <b>setValue</b> to create the name of the timed event. 

<h3>TIMING_VALUE</h3>
The <b>TIMING_VALUE</b> is used with the <b>setValue</b> to create the timing measurement in milliseconds. 

<h3>TIMING_LABEL</h3>
The <b>TIMING_VAR</b> is used with the <b>setValue</b> to create the label of the timed event.


<h2>Error Reporting Properties</h2>

<h3>EX_DESCRIPTION</h3>
The <b>EX_DESCRIPTION</b> is used with the <b>setValue</b> to create a description of the exception (up to 100 characters). Accepts null.

<h3>EX_FATAL</h3>
The <b>EX_FATAL</b> is used with the <b>setValue</b> indicates whether the exception was fatal. YES indicates fatal.

<h2>Helper Module Properties</h2>

<h3>HELPER_CONSTANT_TRUE</h3>

Since all input values for Google Analytics are strings, the <b>HELPER_CONSTANT_TRUE</b> property provides the correct boolean "true" value for the platform.


<h3>HELPER_CONSTANT_FALSE</h3>

Since all input values for Google Analytics are strings, the <b>HELPER_CONSTANT_FALSE</b> property provides the correct boolean "false" value for the platform.


<h2>Other Module Properties</h2>

<h3>REFERRER</h3>
<h3>PAGE</h3>
<h3>JAVA_ENABLED</h3>
<h3>FLASH_VERSION</h3>
<h3>NON_INTERACTION</h3>
<h3>ENCODING</h3>
<h3>HOSTNAME</h3>
<h3>SCREEN_COLORS</h3>
<h3>SCREEN_RESOLUTION</h3>
<h3>VIEWPORT_SIZE</h3>
<h3>CLIENT_ID</h3>
<h3>LOCATION</h3>
<h3>APP_INSTALLER_ID</h3>
<h3>SAMPLE_RATE</h3>
<h3>DESCRIPTION</h3>
<h3>TITLE</h3>
<h3>HIT_TYPE</h3>
