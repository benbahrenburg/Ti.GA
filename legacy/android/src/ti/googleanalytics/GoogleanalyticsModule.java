
//Project forked from MattTuttle
//https://github.com/MattTuttle/titanium-google-analytics
	
package ti.googleanalytics;

import org.appcelerator.kroll.KrollModule;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.titanium.TiApplication;
import com.google.android.gms.analytics.GoogleAnalytics;

@Kroll.module(name = "Googleanalytics", id = "ti.googleanalytics")
public class GoogleanalyticsModule extends KrollModule {

		private GoogleAnalytics mInstance;

		// You can define constants with @Kroll.constant, for example:
		// @Kroll.constant public static final String EXTERNAL_NAME = value;

		public GoogleanalyticsModule()
		{
			super();			
			mInstance = GoogleAnalytics.getInstance(TiApplication.getInstance().getCurrentActivity());
		}

		@Kroll.onAppCreate
		public static void onAppCreate(TiApplication app){}

		// Methods
		@Kroll.method
		public TrackerProxy getTracker(String trackingID)
		{
			return new TrackerProxy(mInstance.newTracker(trackingID));
		}

		@Kroll.setProperty
		public void setLocalDispatchPeriod(int interval)
		{
			mInstance.setLocalDispatchPeriod(interval);
		}

		@Kroll.setProperty
		public void setOptOut(boolean optOut)
		{
			mInstance.setAppOptOut(optOut);
		}

		@Kroll.setProperty
		public void setDryRun(boolean debug)
		{
			mInstance.setDryRun(debug);
		}

}
