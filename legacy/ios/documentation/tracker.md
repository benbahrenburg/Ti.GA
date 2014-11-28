# Tracker

## Description
Tracks analytics data.

## Methods

### String getName()
Returns the name of the tracker. If no name was specified when you retrieved the tracker, then the trackingId will be returned.

### String get(Field key)
Returns the default value for the specified field.

### void set(Field key, String value)
Sets the default value for the specified field. All "sends" will contain this.

### void send(Dictionary args)
Sends data to the server. Use the Map Builder to make it easier to create the arguments for this method.