/**
 * Ti.GA - Google Analytics for Titanium
 * Copyright (c) 2013 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * Available at https://github.com/benbahrenburg/Ti.GA
 */
package ti.ga;

import org.appcelerator.kroll.common.Log;

import com.sun.istack.internal.Nullable;

import android.content.Context;
import android.content.pm.PackageManager.NameNotFoundException;

public class Util {

	 public static String nullToEmpty(@Nullable String string) {
		 return (string == null) ? "" : string;
	 }

	 public static @Nullable String emptyToNull(@Nullable String string) {
		 return isNullOrEmpty(string) ? null : string;
	 }

	 public static boolean isNullOrEmpty(@Nullable String string) {
		 return string == null || string.length() == 0;
	 }
		  
	public static String getApplicationPackageName(Context context){
		try {
			return context.getPackageManager().
					getPackageInfo(context.getPackageName(), 0).packageName;
		} catch (NameNotFoundException e) {
			Util.LogError("[ERROR] failed getting app packageName due to " + e.getMessage());
			return "";
		}		
	}
	public static String getApplicationVersion(Context context){
		try {
			return context.getPackageManager().
					getPackageInfo(context.getPackageName(), 0).versionName;
		} catch (NameNotFoundException e) {
			Util.LogError("[ERROR] failed getting app version due to " + e.getMessage());
			return "";
		}		
	}
	public static String getApplicationName(Context context) {
	    return (String) context.getApplicationInfo().loadLabel(context.getPackageManager());
	}
	public static void LogInfo(String message)
	{
		Log.i(TigaModule.MODULE_SHORT_NAME,"[INFO] " +message);			
	}
	public static void LogError(String message)
	{
		Log.e(TigaModule.MODULE_SHORT_NAME,"[ERROR] " + message);			
	}
	public static void LogDebug(String message)
	{
		if(TigaModule.DEBUG){
			Log.d(TigaModule.MODULE_SHORT_NAME,"[DEBUG] " + message);
		}				
	}
}
