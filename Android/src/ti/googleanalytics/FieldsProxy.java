package ti.googleanalytics;

import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

@Kroll.proxy
public class FieldsProxy extends KrollProxy {

	public FieldsProxy() {
	}

	@Kroll.constant public static final String ANONYMIZE_IP = "&aip";
	@Kroll.constant public static final String HIT_TYPE = "&t";
	@Kroll.constant public static final String SESSION_CONTROL = "&sc";
	@Kroll.constant public static final String NON_INTERACTION = "&ni";
	@Kroll.constant public static final String DESCRIPTION = "&cd";
	@Kroll.constant public static final String SCREEN_NAME = "&cd";
	@Kroll.constant public static final String LOCATION = "&dl";
	@Kroll.constant public static final String REFERRER = "&dr";
	@Kroll.constant public static final String PAGE = "&dp";
	@Kroll.constant public static final String HOSTNAME = "&dh";
	@Kroll.constant public static final String TITLE = "&dt";
	@Kroll.constant public static final String LANGUAGE = "&ul";
	@Kroll.constant public static final String ENCODING = "&de";
	@Kroll.constant public static final String SCREEN_COLORS = "&sd";
	@Kroll.constant public static final String SCREEN_RESOLUTION = "&sr";
	@Kroll.constant public static final String VIEWPORT_SIZE = "&vp";
	@Kroll.constant public static final String CLIENT_ID = "&cid";
	@Kroll.constant public static final String CAMPAIGN_NAME = "&cn";
	@Kroll.constant public static final String CAMPAIGN_SOURCE = "&cs";
	@Kroll.constant public static final String CAMPAIGN_MEDIUM = "&cm";
	@Kroll.constant public static final String CAMPAIGN_KEYWORD = "&ck";
	@Kroll.constant public static final String CAMPAIGN_CONTENT = "&cc";
	@Kroll.constant public static final String CAMPAIGN_ID = "&ci";
	@Kroll.constant public static final String EVENT_CATEGORY = "&ec";
	@Kroll.constant public static final String EVENT_ACTION = "&ea";
	@Kroll.constant public static final String EVENT_LABEL = "&el";
	@Kroll.constant public static final String EVENT_VALUE = "&ev";
	@Kroll.constant public static final String SOCIAL_NETWORK = "&sn";
	@Kroll.constant public static final String SOCIAL_ACTION = "&sa";
	@Kroll.constant public static final String SOCIAL_TARGET = "&st";
	@Kroll.constant public static final String TIMING_VAR = "&utv";
	@Kroll.constant public static final String TIMING_VALUE = "&utt";
	@Kroll.constant public static final String TIMING_CATEGORY = "&utc";
	@Kroll.constant public static final String TIMING_LABEL = "&utl";
	@Kroll.constant public static final String APP_NAME = "&an";
	@Kroll.constant public static final String APP_ID = "&aid";
	@Kroll.constant public static final String APP_INSTALLER_ID = "&aiid";
	@Kroll.constant public static final String APP_VERSION = "&av";
	@Kroll.constant public static final String EX_DESCRIPTION = "&exd";
	@Kroll.constant public static final String EX_FATAL = "&exf";
	@Kroll.constant public static final String CURRENCY_CODE = "&cu";
	@Kroll.constant public static final String TRANSACTION_ID = "&ti";
	@Kroll.constant public static final String TRANSACTION_AFFILIATION = "&ta";
	@Kroll.constant public static final String TRANSACTION_SHIPPING = "&ts";
	@Kroll.constant public static final String TRANSACTION_TAX = "&tt";
	@Kroll.constant public static final String TRANSACTION_REVENUE = "&tr";
	@Kroll.constant public static final String ITEM_SKU = "&ic";
	@Kroll.constant public static final String ITEM_NAME = "&in";
	@Kroll.constant public static final String ITEM_CATEGORY = "&iv";
	@Kroll.constant public static final String ITEM_PRICE = "&ip";
	@Kroll.constant public static final String ITEM_QUANTITY = "&iq";
	@Kroll.constant public static final String TRACKING_ID = "&tid";
	@Kroll.constant public static final String SAMPLE_RATE = "&sf";
	@Kroll.constant public static final String JAVA_ENABLED = "&je";
	@Kroll.constant public static final String FLASH_VERSION = "&fl";
	@Kroll.constant public static final String USE_SECURE = "useSecure";
	@Kroll.constant public static final String ANDROID_APP_UID = "AppUID";
}
