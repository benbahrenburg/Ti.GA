/**
 * Copyright (c) 2013 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
package ti.ga;

import java.util.HashMap;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.titanium.TiApplication;
import org.appcelerator.titanium.util.TiConvert;
import com.google.analytics.tracking.android.Tracker;

@Kroll.proxy(creatableInModule=TigaModule.class)
public class TrackerObjectProxy extends KrollProxy {

	private Tracker _Tracker; //Local access for our tracker object
	
	//Local defaults
	private String _TrackerId = ""; 
	private boolean _AnonymizeIp = false;
	private boolean _UseHTTPS = false;
	private String _AppName;
	private String _AppVersion;
	private double _SampleRate = 100;
	private boolean _SessionStarted = false;
	private boolean _ThrottlingEnabled = false;

	public TrackerObjectProxy(Tracker tracker, String trackerId, KrollDict args)
	{
		super();
		_Tracker = tracker;
		_TrackerId = trackerId;
		applyProperties(args);
	}
	
	private void applyProperties(KrollDict args){
		
		if(args.containsKey("appId")){
			setAppId(args.getString("appId"));
		}else{
			String packageName = Util.getApplicationPackageName(TiApplication.getInstance().getApplicationContext());
			if(!Util.isNullOrEmpty(packageName)){
				setAppId(packageName);	
			}					
		}

		if(args.containsKey("appName")){
			setAppName(args.getString("appName"));
		}else{
			String name = Util.getApplicationName(TiApplication.getInstance().getApplicationContext());
			if(!Util.isNullOrEmpty(name)){
				setAppName(name);	
			}		
		}
		
		if(args.containsKey("appVersion")){
			setAppVersion(args.getString("appVersion"));
		}else{			
			String version = Util.getApplicationVersion(TiApplication.getInstance().getApplicationContext());
			if(!Util.isNullOrEmpty(version)){
				setAppVersion(version);	
			}
		}
		
		if(args.containsKey("throttlingEnabled")){
			setThrottlingEnabled(args.optBoolean("throttlingEnabled", false));
		}
		if(args.containsKey("useHttps")){
			setUseHTTPS(args.optBoolean("useHttps", false));
		}

		if(args.containsKey("anonymize")){
			setAnonymize(args.optBoolean("anonymize", false));
		}
		
		if(args.containsKey("sampleRate")){
			setSampleRate(args.getDouble("sampleRate"));
		}
		
		if(args.containsKey("sessionStart")){
			setSessionStart(args.optBoolean("sessionStart", true));
		}
	}
	
	@Kroll.getProperty
	public String trackerId()
	{
		return _TrackerId;
	}
	
	@Kroll.method
	public void sendView(String view)
	{
		Util.LogDebug("sendView view =" + view);
		_Tracker.sendView(view);
	}

	@Kroll.method
	public void sendException(String description)
	{
		Util.LogDebug("sendException description =" + description);
		_Tracker.sendException(description, false);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Kroll.method
	public void sendSocial(HashMap hm)
	{
		Util.LogDebug("sendSocial called");
		KrollDict args = new KrollDict(hm);
		String network = TiConvert.toString(args, "network");
		String action = TiConvert.toString(args, "action");
		String target = TiConvert.toString(args, "target");
		_Tracker.sendSocial(network, action, target);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Kroll.method
	public void send(String hitType, HashMap hm)
	{
		Util.LogDebug("send called");
		_Tracker.send(hitType, hm);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Kroll.method
	public void sendEvent(HashMap hm)
	{
		Util.LogDebug("sendEvent called");
		KrollDict args = new KrollDict(hm);
		String category = TiConvert.toString(args, "category");
		String action = TiConvert.toString(args, "action");
		String label = TiConvert.toString(args, "label");
		long value = TiConvert.toInt(args, "value");
		_Tracker.sendEvent(category, action, label, value);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Kroll.method
	public void addCustomDimension(HashMap hm)
	{
		Util.LogDebug("sendTiming called");
		KrollDict args = new KrollDict(hm);
		int index = TiConvert.toInt(args,"index");
		String dimesion = TiConvert.toString(args,"dimesion");
		_Tracker.setCustomDimension(index, dimesion);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Kroll.method
	public void addCustomMetric(HashMap hm)
	{
		Util.LogDebug("sendTiming called");
		KrollDict args = new KrollDict(hm);
		int index = TiConvert.toInt(args,"index");
		long metric = (long)TiConvert.toDouble(args,"metric");
		_Tracker.setCustomMetric(index, metric);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Kroll.method
	public void sendTiming(HashMap hm)
	{
		Util.LogDebug("sendTiming called");
		KrollDict args = new KrollDict(hm);
		String category = TiConvert.toString(args, "category");
		String name = TiConvert.toString(args, "name");
		String label = TiConvert.toString(args, "label");
		double interval = TiConvert.toDouble(args, "value");
		_Tracker.sendTiming(category, ((long) interval), name, label);
	}
	
	@Kroll.getProperty
	public String getAppName() {
		return _AppName;
	}

	@Kroll.setProperty
	public void setAppName(String value) {
		Util.LogDebug("setAppName = " + value);
		_AppName = value;
		_Tracker.setAppName(_AppName);
	}
	
	@Kroll.getProperty
	public String getAppId() {
		return _Tracker.getAppId();
	}

	@Kroll.setProperty
	public void setAppId(String value) {
		Util.LogDebug("setAppId = " + value);
		_Tracker.setAppId(value);
	}
	
	@Kroll.getProperty
	public String getAppVersion() {
		return _AppVersion;
	}

	@Kroll.setProperty
	public void setAppVersion(String value) {
		Util.LogDebug("setAppVersion = " + value);
		_AppVersion = value;
		_Tracker.setAppVersion(_AppVersion);
	}
	
	@Kroll.method
	public void close() {
		Util.LogDebug("close called");
		_Tracker.close();
	}
	
	@Kroll.getProperty
	public double getSampleRate() {
		return _SampleRate;
	}

	@Kroll.setProperty
	public void setSampleRate(double value) {
		Util.LogDebug("setSampleRate = " + value);
		_SampleRate = value;
		_Tracker.setSampleRate(_SampleRate);
	}
	
	@Kroll.getProperty
	public boolean getSessionStart() {
		return _SessionStarted;
	}

	@Kroll.setProperty
	public void setSessionStart(boolean value) {
		Util.LogDebug("setSessionStart = " + value);
		_SessionStarted = value;
		_Tracker.setStartSession(_SessionStarted);
	}
	
	@Kroll.getProperty
	public boolean getUseHTTP() {
		return _UseHTTPS;
	}
	
	@Kroll.setProperty
	public void setUseHTTPS(boolean value) {
		Util.LogDebug("setUseHTTPS = " + value);
		_UseHTTPS = value;
		_Tracker.setUseSecure(_UseHTTPS);
	}
	
	@Kroll.getProperty
	public boolean getAnonymize() {
		return _AnonymizeIp;
	}
	
	@Kroll.setProperty
	public void setAnonymize(boolean value) {
		_AnonymizeIp = value;
		_Tracker.setAnonymizeIp(_AnonymizeIp);
	}

	@Kroll.getProperty
	public double getSessionTimeout(){
		Util.LogDebug("Session Timeout not used on Android");
		return 0;
	}
	
	@Kroll.setProperty
	public void setSessionTimeout(double value){
		Util.LogDebug("Session Timeout not used on Android");
	}
	
	@Kroll.getProperty
	public boolean getThrottlingEnabled(){
		return _ThrottlingEnabled;
	}
	
	@Kroll.setProperty
	public void setThrottlingEnabled(boolean value){
		_ThrottlingEnabled = value;
		_Tracker.setThrottlingEnabled(_ThrottlingEnabled);
	}
}
