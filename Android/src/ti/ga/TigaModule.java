/**
 * Copyright (c) 2013 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
package ti.ga;

import java.util.HashMap;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.KrollModule;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.titanium.TiApplication;

import com.google.analytics.tracking.android.GoogleAnalytics;
import com.google.analytics.tracking.android.GAServiceManager;

@Kroll.module(name="Tiga", id="ti.ga")
public class TigaModule extends KrollModule
{

	// Standard Debugging variables
	public static boolean DEBUG = false;
	public static final String MODULE_SHORT_NAME = "ti.ga";	
	private GoogleAnalytics _ga;
	private boolean _optOut = false;
	public TigaModule()
	{
		super();
		_ga = GoogleAnalytics.getInstance(TiApplication.getInstance().getRootOrCurrentActivity());
	}

	@SuppressWarnings({"rawtypes", "unchecked" })
	@Kroll.method
	public TrackerObjectProxy createTracker(HashMap hm)
	{
		Util.LogDebug("calling createTracker");
		KrollDict args = new KrollDict(hm);
		
		if(args.containsKey("trackingId")){
			String trackerId =  args.getString("trackingId");
			Util.LogDebug("Has trackingId " + trackerId);
			return new TrackerObjectProxy(_ga.getTracker(trackerId),trackerId,args);			
		}else{
			return new TrackerObjectProxy(_ga.getDefaultTracker(),"",args);
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
		_ga.setDebug(value);
	}

	@Kroll.method
	public void dispatch()
	{
		Util.LogDebug("dispatch called");
		GAServiceManager.getInstance().dispatch();
	}
	
	@Kroll.setProperty
	public void setDispatchInterval(int interval)
	{
		Util.LogDebug("setDispatchInterval = " + interval);
		GAServiceManager.getInstance().setDispatchPeriod(interval);
	}
	// Properties
	@Kroll.getProperty
	public boolean getOptOut()
	{
		return _optOut;
	}
	
	@Kroll.setProperty
	public void setOptOut(boolean value) {
		Util.LogDebug("setOptOut =" + value);
		_optOut = value;
		_ga.setAppOptOut(_optOut);
	}
}

