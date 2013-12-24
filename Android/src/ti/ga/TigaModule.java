/**
 * Ti.GA - Google Analytics for Titanium
 * Copyright (c) 2013 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * Available at https://github.com/benbahrenburg/Ti.GA
 */
package ti.ga;

import java.lang.Thread.UncaughtExceptionHandler;
import java.util.HashMap;

import org.appcelerator.kroll.KrollModule;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.titanium.TiApplication;

import android.app.Activity;

import com.google.analytics.tracking.android.ExceptionReporter;
import com.google.analytics.tracking.android.Fields;
import com.google.analytics.tracking.android.GoogleAnalytics;
import com.google.analytics.tracking.android.GAServiceManager;
import com.google.analytics.tracking.android.Logger.LogLevel;
import com.google.analytics.tracking.android.Tracker;

@Kroll.module(name="Tiga", id="ti.ga")
public class TigaModule extends KrollModule
{

	// Standard Debugging variables
	public static boolean DEBUG = false;
	public static final String MODULE_SHORT_NAME = "ti.ga";	
	private GoogleAnalytics _ga = null;
	private boolean _errorHandler = false;
	
	public TigaModule()
	{
		super();
		_ga = GoogleAnalytics.getInstance(TiApplication.getInstance().getRootOrCurrentActivity());
	}

	@SuppressWarnings({"rawtypes"})
	@Kroll.method
	public TrackerObjectProxy createTracker(HashMap hm)
	{
		Util.LogDebug("calling createTracker");		
		if(hm.containsKey(Fields.TRACKING_ID)){			
			String trackerId =  hm.get(Fields.TRACKING_ID).toString();
			Util.LogDebug("Has trackingId " + trackerId);
			return new TrackerObjectProxy(_ga.getTracker(trackerId),trackerId,hm);			
		}else{
			return new TrackerObjectProxy(_ga.getDefaultTracker(),"",hm);
		}
	}
	// Properties
	@Kroll.getProperty
	public boolean getDebug()
	{
		return DEBUG;
	}
	
	@Kroll.setProperty
	public void setDebug(boolean value) {
		DEBUG = value;
		if(DEBUG){
			GoogleAnalytics.getInstance(TiApplication.getInstance().getRootOrCurrentActivity())
		    .getLogger()
		    .setLogLevel(LogLevel.VERBOSE);
			Util.LogDebug("Debugging Enabled");	
		}else{
			GoogleAnalytics.getInstance(TiApplication.getInstance().getRootOrCurrentActivity())
		    .getLogger()
		    .setLogLevel(LogLevel.WARNING);
			Util.LogDebug("Debugging Disabled, only warnings will show");	
		}
	}

	@SuppressWarnings("deprecation")
	@Kroll.method
	public void dispatch()
	{
		Util.LogDebug("dispatch called");
		GAServiceManager.getInstance().dispatchLocalHits();
	}
	
	@SuppressWarnings("deprecation")
	@Kroll.method
	public void setDispatchInterval(int interval)
	{
		Util.LogDebug("setDispatchInterval = " + interval);
		GAServiceManager.getInstance().setLocalDispatchPeriod(interval);
	}
	// Properties
	@Kroll.getProperty
	public boolean getOptOut()
	{
		return GoogleAnalytics.getInstance(TiApplication.getInstance().getRootOrCurrentActivity()).getAppOptOut();
	}
	
	@Kroll.setProperty
	public void setOptOut(boolean value) {
		Util.LogDebug("setOptOut =" + value);
		_ga.setAppOptOut(value);
	}
	
	@Kroll.method
	public boolean isTrackUncaughtExceptionsActive(){
		return _errorHandler;
	}
	
	@Kroll.method
	public void enableTrackUncaughtExceptions(){
		Tracker tracker = GoogleAnalytics.getInstance(TiApplication.getInstance().getRootOrCurrentActivity()).getDefaultTracker();
		if(tracker == null){
			Util.LogError("Tracker has not yet been created. At least one must be created for enableTrackUncaughtExceptions can be set");
			return;
		}
		UncaughtExceptionHandler gaErrHandler = new ExceptionReporter(
				tracker, // Tracker, may return null if not yet initialized.
			    GAServiceManager.getInstance(),                        // GAServiceManager singleton.
			    Thread.getDefaultUncaughtExceptionHandler(), null);          // Current default uncaught exception handler.

			// Make myHandler the new default uncaught exception handler.
			Thread.setDefaultUncaughtExceptionHandler(gaErrHandler);
			_errorHandler = true;
			Util.LogDebug("UncaughtExceptions enabled");	
	}
	
	@Override
    public void onDestroy(Activity activity) 
    {
		if(_ga!=null){
			_ga = null;
		}
        super.onDestroy(activity);
    }
	
	 @Kroll.constant public static final String ANONYMIZE_IP = Fields.ANONYMIZE_IP;
	 @Kroll.constant public static final String HIT_TYPE = Fields.HIT_TYPE;
	 @Kroll.constant public static final String SESSION_CONTROL = Fields.SESSION_CONTROL;
	 @Kroll.constant public static final String NON_INTERACTION = Fields.NON_INTERACTION;
	 @Kroll.constant public static final String DESCRIPTION = Fields.DESCRIPTION;
	 @Kroll.constant public static final String SCREEN_NAME = Fields.SCREEN_NAME;
	 @Kroll.constant public static final String LOCATION = Fields.LOCATION;
	 @Kroll.constant public static final String REFERRER = Fields.REFERRER;
	 @Kroll.constant public static final String PAGE = Fields.PAGE;
	 @Kroll.constant public static final String HOSTNAME = Fields.HOSTNAME;
	 @Kroll.constant public static final String TITLE = Fields.TITLE;
	 @Kroll.constant public static final String LANGUAGE = Fields.LANGUAGE;
	 @Kroll.constant public static final String TRACKING_ID = Fields.TRACKING_ID;
	 @Kroll.constant public static final String ENCODING = Fields.ENCODING;
	 @Kroll.constant public static final String SCREEN_COLORS = Fields.SCREEN_COLORS;
	 @Kroll.constant public static final String SCREEN_RESOLUTION = Fields.SCREEN_RESOLUTION;
	 @Kroll.constant public static final String VIEWPORT_SIZE = Fields.VIEWPORT_SIZE;
	 @Kroll.constant public static final String CLIENT_ID = Fields.CLIENT_ID;
	 @Kroll.constant public static final String CAMPAIGN_NAME = Fields.CAMPAIGN_NAME;
	 @Kroll.constant public static final String CAMPAIGN_SOURCE = Fields.CAMPAIGN_SOURCE;
	 @Kroll.constant public static final String CAMPAIGN_MEDIUM = Fields.CAMPAIGN_MEDIUM;
	 @Kroll.constant public static final String CAMPAIGN_KEYWORD = Fields.CAMPAIGN_KEYWORD;
	 @Kroll.constant public static final String CAMPAIGN_CONTENT = Fields.CAMPAIGN_CONTENT;
	 @Kroll.constant public static final String CAMPAIGN_ID = Fields.CAMPAIGN_ID;
	 @Kroll.constant public static final String EVENT_CATEGORY = Fields.EVENT_CATEGORY;
	 @Kroll.constant public static final String EVENT_ACTION = Fields.EVENT_ACTION;
	 @Kroll.constant public static final String EVENT_LABEL = Fields.EVENT_LABEL;
	 @Kroll.constant public static final String EVENT_VALUE = Fields.EVENT_VALUE;
	 @Kroll.constant public static final String SOCIAL_NETWORK = Fields.SOCIAL_NETWORK;
	 @Kroll.constant public static final String SOCIAL_ACTION = Fields.SOCIAL_ACTION;
	 @Kroll.constant public static final String SOCIAL_TARGET = Fields.SOCIAL_TARGET;
	 @Kroll.constant public static final String TIMING_CATEGORY = Fields.TIMING_CATEGORY;
	 @Kroll.constant public static final String TIMING_VAR = Fields.TIMING_VAR;
	 @Kroll.constant public static final String TIMING_VALUE = Fields.TIMING_VALUE;
	 @Kroll.constant public static final String TIMING_LABEL = Fields.TIMING_LABEL;
	 @Kroll.constant public static final String APP_NAME = Fields.APP_NAME;
	 @Kroll.constant public static final String APP_ID = Fields.APP_ID;
	 @Kroll.constant public static final String APP_INSTALLER_ID = Fields.APP_INSTALLER_ID;
	 @Kroll.constant public static final String APP_VERSION = Fields.APP_VERSION;
	 @Kroll.constant public static final String EX_DESCRIPTION = Fields.EX_DESCRIPTION;
	 @Kroll.constant public static final String EX_FATAL = Fields.EX_FATAL;
	 @Kroll.constant public static final String CURRENCY_CODE = Fields.CURRENCY_CODE;
	 @Kroll.constant public static final String TRANSACTION_ID = Fields.TRANSACTION_ID;
	 @Kroll.constant public static final String TRANSACTION_AFFILIATION = Fields.TRANSACTION_AFFILIATION;
	 @Kroll.constant public static final String TRANSACTION_SHIPPING = Fields.TRANSACTION_SHIPPING;
	 @Kroll.constant public static final String TRANSACTION_TAX = Fields.TRANSACTION_TAX;
	 @Kroll.constant public static final String TRANSACTION_REVENUE = Fields.TRANSACTION_REVENUE;
	 @Kroll.constant public static final String ITEM_PRICE = Fields.ITEM_PRICE;
	 @Kroll.constant public static final String ITEM_QUANTITY = Fields.ITEM_QUANTITY;
	 @Kroll.constant public static final String ITEM_SKU = Fields.ITEM_SKU;
	 @Kroll.constant public static final String ITEM_NAME = Fields.ITEM_NAME;
	 @Kroll.constant public static final String ITEM_CATEGORY = Fields.ITEM_CATEGORY;
	 @Kroll.constant public static final String SAMPLE_RATE = Fields.SAMPLE_RATE;
	 @Kroll.constant public static final String JAVA_ENABLED = Fields.JAVA_ENABLED;
	 @Kroll.constant public static final String FLASH_VERSION = Fields.FLASH_VERSION;
	 @Kroll.constant public static final String USE_SECURE = Fields.USE_SECURE;
	 
	 @Kroll.constant public static final String HELPER_CONSTANT_TRUE = "true";
	 @Kroll.constant public static final String HELPER_CONSTANT_FALSE = "false";
	 
	 //Android only properties
	 @Kroll.constant public static final String ANDROID_APP_UID = Fields.ANDROID_APP_UID;
	 
}

