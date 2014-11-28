//Project forked from MattTuttle
//https://github.com/MattTuttle/titanium-google-analytics

package ti.googleanalytics;
import java.util.HashMap;
import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.titanium.util.TiConvert;

import com.google.android.gms.analytics.HitBuilders;
import com.google.android.gms.analytics.Tracker;

@Kroll.proxy
public class TrackerProxy extends KrollProxy {
	
	private Tracker _tracker;

	// Constructor
	public TrackerProxy(Tracker t)
	{
		super();
		_tracker = t;
	}

	@Kroll.method
	public void setScreenName(String path)
	{
		_tracker.setScreenName(path);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Kroll.method
	public void trackEvent(HashMap props)
	{
		KrollDict propsDict = new KrollDict(props);
		String category = TiConvert.toString(propsDict, "category");
		String action = TiConvert.toString(propsDict, "action");
		String label = TiConvert.toString(propsDict, "label");
		long value = TiConvert.toInt(propsDict, "value");
		
		HitBuilders.EventBuilder hitBuilder = new HitBuilders.EventBuilder()
			.setCategory(category)
			.setAction(action)
			.setLabel(label)
			.setValue(value);
		
		
		// custom dimension
		Object cd = propsDict.get("customDimension");
		if (cd instanceof HashMap) {
			HashMap dict = (HashMap) cd;
			for (Object key : dict.keySet()) {
				int idx = TiConvert.toInt(key);
				String val = TiConvert.toString(dict.get(key));
				
				if (idx > 0) {
					hitBuilder.setCustomDimension(idx, val);
				}
			}
		}
		
		// custom metric
		Object cm = propsDict.get("customMetric");
		if (cm instanceof HashMap) {
			HashMap dict = (HashMap) cm;
			
			for (Object key : dict.keySet()) {
				int idx = TiConvert.toInt(key);
				float val = TiConvert.toFloat(dict.get(key));
				
				if (idx > 0) {
					hitBuilder.setCustomMetric(idx, val);
				}
			}
		}
		
		_tracker.send(hitBuilder.build());
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Kroll.method
	public void trackScreen(HashMap props)
	{
		KrollDict propsDict = new KrollDict(props);
		String path = TiConvert.toString(propsDict, "path");
		
		_tracker.setScreenName(path);
		
		HitBuilders.AppViewBuilder hitBuilder = new HitBuilders.AppViewBuilder();
		
		// custom dimension
		Object cd = propsDict.get("customDimension");
		if (cd instanceof HashMap) {
			HashMap dict = (HashMap) cd;
			for (Object key : dict.keySet()) {
				int idx = TiConvert.toInt(key);
				String val = TiConvert.toString(dict.get(key));
			
				if (idx > 0) {
					hitBuilder.setCustomDimension(idx, val);
				}
			}
		}
				
		// custom metric
		Object cm = propsDict.get("customMetric");
		if (cm instanceof HashMap) {
			HashMap dict = (HashMap) cm;
		
			for (Object key : dict.keySet()) {
				int idx = TiConvert.toInt(key);
				float val = TiConvert.toFloat(dict.get(key));
			
				if (idx > 0) {
					hitBuilder.setCustomMetric(idx, val);
				}
			}
		}
		
		_tracker.send(hitBuilder.build());
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Kroll.method
	public void trackTiming(HashMap props)
	{
		KrollDict propsDict = new KrollDict(props);
		String category = TiConvert.toString(propsDict, "category");
		String name = TiConvert.toString(propsDict, "name");
		String label = TiConvert.toString(propsDict, "label");
		long interval = TiConvert.toInt(propsDict, "time");
		
		
		HitBuilders.TimingBuilder hitBuilder = new HitBuilders.TimingBuilder()
			.setCategory(category)
			.setValue(interval)
			.setVariable(name)
			.setLabel(label);
		
		
		// custom dimension
		Object cd = propsDict.get("customDimension");
		if (cd instanceof HashMap) {
			HashMap dict = (HashMap) cd;
			for (Object key : dict.keySet()) {
				int idx = TiConvert.toInt(key);
				String val = TiConvert.toString(dict.get(key));
				
				if (idx > 0) {
					hitBuilder.setCustomDimension(idx, val);
				}
			}
		}
		
		// custom metric
		Object cm = propsDict.get("customMetric");
		if (cm instanceof HashMap) {
			HashMap dict = (HashMap) cm;
			
			for (Object key : dict.keySet()) {
				int idx = TiConvert.toInt(key);
				float val = TiConvert.toFloat(dict.get(key));
				
				if (idx > 0) {
					hitBuilder.setCustomMetric(idx, val);
				}
			}
		}
		
		_tracker.send(hitBuilder.build());
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Kroll.method
	public void sendException(HashMap props)
	{
		KrollDict args = new KrollDict(props);
		String description = TiConvert.toString(args, "description");		
		_tracker.send(new HitBuilders.ExceptionBuilder()
	        .setDescription(description)
	        .setFatal(args.optBoolean("fatal", false))
	        .build());		
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Kroll.method
	public void trackSocial(HashMap props)
	{
		KrollDict propsDict = new KrollDict(props);
		String network = TiConvert.toString(propsDict, "network");
		String action = TiConvert.toString(propsDict, "action");
		String target = TiConvert.toString(propsDict, "target");
		
		
		HitBuilders.SocialBuilder hitBuilder = new HitBuilders.SocialBuilder()
			.setNetwork(network)
			.setAction(action)
			.setTarget(target);
		
		
		// custom dimension
		Object cd = propsDict.get("customDimension");
		if (cd instanceof HashMap) {
			HashMap dict = (HashMap) cd;
			for (Object key : dict.keySet()) {
				int idx = TiConvert.toInt(key);
				String val = TiConvert.toString(dict.get(key));
				
				if (idx > 0) {
					hitBuilder.setCustomDimension(idx, val);
				}
			}
		}
		
		// custom metric
		Object cm = propsDict.get("customMetric");
		if (cm instanceof HashMap) {
			HashMap dict = (HashMap) cm;
			
			for (Object key : dict.keySet()) {
				int idx = TiConvert.toInt(key);
				float val = TiConvert.toFloat(dict.get(key));
				
				if (idx > 0) {
					hitBuilder.setCustomMetric(idx, val);
				}
			}
		}
		
		_tracker.send(hitBuilder.build());
	}
}