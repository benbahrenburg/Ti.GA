// TODO: Replace the below tracking ID with your own from Google Analytics.
var GoogleAnalytics = require('ti.googleanalytics'),
	tracker = GoogleAnalytics.getTracker('UA-43282251-1'),
	Fields = GoogleAnalytics.getFields(),
	MapBuilder = GoogleAnalytics.getMapBuilder();

var win = Ti.UI.createWindow({
	backgroundColor: '#fff'
});
win.addEventListener('open', function(evt) {
	tracker.send(
		MapBuilder
			.createAppView()
			.set(Fields.SCREEN_NAME, 'home')
			.build()
	);
});

var button = Ti.UI.createButton({
	title: 'Track Click'
});
button.addEventListener('click', function() {
	tracker.send(
		MapBuilder
			.createEvent('ui_action', 'button_press', 'send_button')
			.build()
	);
});
win.add(button);

win.open();