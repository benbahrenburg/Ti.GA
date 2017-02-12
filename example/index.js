var ga = require('ti.ga');
Ti.API.info("module is => " + ga);

ga.setOptOut(false);
ga.setDebug(true);

var tracker = ga.createTracker({
   trackingId:'UA-XXXXXX-Y',
   useSecure:true,
   debug:true 
});

Ti.API.info("tracker is => " + JSON.stringify(tracker));

tracker.startSession();
tracker.addScreenView('my-cool-view');
    
function doClick(e) {
    tracker.addScreenView('my-cool-view2');
    tracker.addEvent({
        category:"myCategory-Event",
        label:"myLabel",
        value:1
    });  
    tracker.addTiming({
        category:"myCategory-Timing",
        label:"myLabel",
        name:"myName",
        time:1
    });
}

$.index.addEventListener('close', function(){
    tracker.endSession();
    ga.dispatch();
});

$.index.open();
