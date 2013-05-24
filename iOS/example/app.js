var ga = require('ti.ga');
Ti.API.info("module is => " + ga);

// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});

win.open();

var tracker = ga.createTracker({
	trackingId : 'your key',
	anonymize:true,
	useHttps:true
});

Ti.API.info('AppName =>' + tracker.appName);
Ti.API.info('AppId =>' + tracker.appId);
Ti.API.info('appVersion =>' + tracker.appVersion);
Ti.API.info('anonymize =>' + tracker.anonymize);
Ti.API.info('useHttps =>' + tracker.useHttps);

tracker.setSessionStart(true);

tracker.sendView("main");
tracker.sendEvent({
	category:'test_category',
	action:'test_action',
	label:'test_label'
});
