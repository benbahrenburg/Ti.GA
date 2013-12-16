var ga = require('ti.ga');

Ti.API.info('Enabled Debug');
ga.debug = true;

Ti.API.info('Is debug enabled? ' + ga.debug);

Ti.API.info('Set Dispatch Interval, this is the number of seconds which GA should wait before automaticaly dispatching');
ga.setDispatchInterval(15);

Ti.API.info('You can opt out by like this');
ga.optOut = true;

Ti.API.info("Let's opt back in");
ga.optOut = false;

Ti.API.info("enable unhandled exception tracking");
ga.enableTrackUncaughtExceptions();

Ti.API.info('You can also manually dispatch all analytics');
Ti.API.info('Recommend only doing this if the device has a connection');

if(Ti.Network.online){
	ga.dispatch();	
}