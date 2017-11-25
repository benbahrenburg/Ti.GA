package ti.ga;

import java.util.HashMap;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.titanium.TiApplication;
import org.appcelerator.titanium.util.TiConvert;

import android.util.Log;

import com.google.android.gms.analytics.GoogleAnalytics;
import com.google.android.gms.analytics.HitBuilders;
import com.google.android.gms.analytics.Tracker;

@Kroll.proxy(creatableInModule=TigaModule.class)
public class TrackerProxy  extends KrollProxy {
	
	private final GoogleAnalytics _ga;
	private Tracker _tracker;
	private boolean _debug = false;
	
	public TrackerProxy()
	{
		super();
		_ga = GoogleAnalytics.getInstance(TiApplication.getInstance().getApplicationContext());
	}

	private interface IBuilder {
		public void setCustomDimension(int idx, String value);

		public void setCustomMetric(int idx, Float value);
	}

	@SuppressWarnings("rawtypes")
	private void handleCustomDimensions(IBuilder builder, Object customDimensions)
	{
		if (customDimensions instanceof HashMap) {
			HashMap dict = (HashMap) customDimensions;
			for (Object key : dict.keySet()) {
				int idx = TiConvert.toInt(key);
				String val = TiConvert.toString(dict.get(key));

				// indexes are 1-based
				if (idx > 0) {
					builder.setCustomDimension(idx, val);
				}
			}
		}
	}

	@SuppressWarnings("rawtypes")
	private void handleCustomMetrics(IBuilder builder, Object customMetrics)
	{
		if (customMetrics instanceof HashMap) {
			HashMap dict = (HashMap) customMetrics;
			for (Object key : dict.keySet()) {
				int idx = TiConvert.toInt(key);
				float val = TiConvert.toFloat(dict.get(key));

				// indexes are 1-based
				if (idx > 0) {
					builder.setCustomMetric(idx, val);
				}
			}
		}
	}

	@Override
	public void handleCreationDict(KrollDict options) 
	{
		_debug = options.optBoolean("debug", false);
		boolean useSecure = options.optBoolean("useSecure", true);
		
		if(options.containsKey("trackingId")){
			_tracker = _ga.newTracker(options.getString("trackingId"));
		}else{
			Log.e(TigaModule.MODULE_FULL_NAME,"trackingId is required");
			_tracker = _ga.newTracker("");
		}
		
		boolean enableAdvertisingIdCollection=options.optBoolean("enableAdvertisingIdCollection", false);
		_tracker.enableAdvertisingIdCollection(enableAdvertisingIdCollection);
		_tracker.setAnonymizeIp(true);
		_tracker.setUseSecure(useSecure);
		
		super.handleCreationDict(options);
	}

	@Kroll.method
	public void setUserID(String userID)
	{
		// Set a user ID for the remainder of the session.
		// See https://developers.google.com/analytics/devguides/collection/android/v4/user-id#implementation
		_tracker.set("&uid", userID);
		if(_debug){
			Log.d(TigaModule.MODULE_FULL_NAME,"setUserID:" + userID);
		}
	}

	@Kroll.method
	public String getUserID()
	{
		return _tracker.get("&uid");
	}

	@Kroll.method
	public void clearUserID()
	{
		_tracker.set("&uid", null);
		if(_debug){
			Log.d(TigaModule.MODULE_FULL_NAME,"clearUserID");
		}
	}
	
	@Kroll.method
	public void startSession(){
	     // Start a new session with the hit.
		_tracker.send(new HitBuilders.AppViewBuilder()
            .setNewSession()
            .build());
	}

	@Kroll.method
	public void endSession(){
		if(_debug){
			Log.d(TigaModule.MODULE_FULL_NAME,"endSession is only available on iOS");
		}		
	}
	
	@Kroll.method
	@SuppressWarnings("rawtypes")
	public void addScreenView(String screenName, HashMap props)
	{
		final HitBuilders.AppViewBuilder hitBuilder = new HitBuilders.AppViewBuilder();
		// Set screen name.
		_tracker.setScreenName(screenName);

		IBuilder builderWrapper = new IBuilder() {
			public void setCustomDimension(int idx, String value) {
				hitBuilder.setCustomDimension(idx, value);
			}
			public void setCustomMetric(int idx, Float value) {
				hitBuilder.setCustomMetric(idx, value);
			}
		};

		handleCustomDimensions(builderWrapper, props.get("customDimension"));
		handleCustomMetrics(builderWrapper, props.get("customMetrics"));

		// Send a screen view.
		_tracker.send(hitBuilder.build());

		if(_debug){
			Log.d(TigaModule.MODULE_FULL_NAME,"addScreenView:" + screenName);
		}
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Kroll.method
	public void addEvent(HashMap props)
	{
		KrollDict args = new KrollDict(props);
		String category = args.getString("category");
		String action = args.getString("action");
		String label = args.getString("label");
		long value = args.getDouble("value").longValue();
		final HitBuilders.EventBuilder hitBuilder = new HitBuilders.EventBuilder();

		hitBuilder.setCategory(category)
			.setAction(action)
			.setLabel(label)
			.setValue(value);

		IBuilder builderWrapper = new IBuilder() {
			public void setCustomDimension(int idx, String value) {
				hitBuilder.setCustomDimension(idx, value);
			}
			public void setCustomMetric(int idx, Float value) {
				hitBuilder.setCustomMetric(idx, value);
			}
		};

		handleCustomDimensions(builderWrapper, props.get("customDimension"));
		handleCustomMetrics(builderWrapper, props.get("customMetrics"));

		_tracker.send(hitBuilder.build());

		if(_debug){
			Log.d(TigaModule.MODULE_FULL_NAME,"addEvent - category:" + category);
			Log.d(TigaModule.MODULE_FULL_NAME,"addEvent - action:" + action);
			Log.d(TigaModule.MODULE_FULL_NAME,"addEvent - label:" + label);
			Log.d(TigaModule.MODULE_FULL_NAME,"addEvent - value:" + Long.toString(value));
		}
		
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Kroll.method
	public void addTiming(HashMap props)
	{
		KrollDict args = new KrollDict(props);
		String category = args.getString("category");
		String name = args.getString("name");
		String label = args.getString("label");
		long time = args.getDouble("time").longValue();	
		final HitBuilders.TimingBuilder hitBuilder = new HitBuilders.TimingBuilder();

		hitBuilder.setCategory(category)
			.setValue(time)
			.setVariable(name)
			.setLabel(label);

		IBuilder builderWrapper = new IBuilder() {
			public void setCustomDimension(int idx, String value) {
				hitBuilder.setCustomDimension(idx, value);
			}
			public void setCustomMetric(int idx, Float value) {
				hitBuilder.setCustomMetric(idx, value);
			}
		};

		handleCustomDimensions(builderWrapper, props.get("customDimension"));
		handleCustomMetrics(builderWrapper, props.get("customMetrics"));

		// Build and send timing.
		_tracker.send(hitBuilder.build());

		if(_debug){
			Log.d(TigaModule.MODULE_FULL_NAME,"addTiming - category:" + category);
			Log.d(TigaModule.MODULE_FULL_NAME,"addTiming - name:" + name);
			Log.d(TigaModule.MODULE_FULL_NAME,"addTiming - label:" + label);
			Log.d(TigaModule.MODULE_FULL_NAME,"addTiming - time:" + Long.toString(time));
		}		
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Kroll.method
	public void addException(HashMap props)
	{
		KrollDict args = new KrollDict(props);
		String description = args.getString("description");
		boolean isFatal = args.optBoolean("fatal", false);
		_tracker.send(new HitBuilders.ExceptionBuilder()
        .setDescription(description)
        .setFatal(isFatal)
        .build());
		
		if(_debug){
			Log.d(TigaModule.MODULE_FULL_NAME,"addException - description:" + description);
			Log.d(TigaModule.MODULE_FULL_NAME,"addException - fatal:" + ((isFatal) ? "true" : "false"));
		}			
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Kroll.method
	public void addSocialNetwork(HashMap props)
	{
		KrollDict args = new KrollDict(props);
		String network = args.getString("network");
		String action = args.getString("action");
		String target = args.getString("target");
		final HitBuilders.SocialBuilder hitBuilder = new HitBuilders.SocialBuilder();

		hitBuilder.setNetwork(network)
			.setAction(action)
			.setTarget(target);

		IBuilder builderWrapper = new IBuilder() {
			public void setCustomDimension(int idx, String value) {
				hitBuilder.setCustomDimension(idx, value);
			}
			public void setCustomMetric(int idx, Float value) {
				hitBuilder.setCustomMetric(idx, value);
			}
		};

		handleCustomDimensions(builderWrapper, props.get("customDimension"));
		handleCustomMetrics(builderWrapper, props.get("customMetrics"));

		// Build and send social interaction.
		_tracker.send(hitBuilder.build());

		if(_debug){
			Log.d(TigaModule.MODULE_FULL_NAME,"addSocialNetwork - network:" + network);
			Log.d(TigaModule.MODULE_FULL_NAME,"addSocialNetwork - action:" + action);
			Log.d(TigaModule.MODULE_FULL_NAME,"addSocialNetwork - target:" + target);
		}		
	}
}
