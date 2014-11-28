# Map Builder

## Description
Makes it easier to build the data payload to send to Google.

## Creation Methods
Call one of these methods first, followed by the normal methods further down in this file.

### MapBuilder createAppView()
### MapBuilder createEvent(String category, String action, String label, Number value)
### MapBuilder createException(String exceptionDescription, Boolean fatal) {
### MapBuilder createItem(String transactionId, String name, String sku, String category, Double price, Long quantity, String currencyCode)
### MapBuilder createSocial(String network, String action, String target)
### MapBuilder createTiming(String category, Long intervalInMilliseconds, String name, String label)
### MapBuilder createTransaction(String transactionId, String affiliation, Double revenue, Double tax, Double shipping, String currencyCode)

## Methods

### String get(String paramName)
Returns the value of the specified parameter.

### MapBuilder set(Field paramName, String paramValue)
Sets the specified parameter and value, and returns the MapBuilder to allow for method chaining.

### MapBuilder setAll(Dictionary args)
Sets all of the specified key-value pairs in the JavaScript dictionary, and returns the MapBuilder to allow for method chaining.

### MapBuilder setCampaignParamsFromUrl(String utmParams)
Sets campaign parameters from the specified URL.

### Dictionary build()
Turns the MapBuilder in to a normal JavaScript Dictionary of values that can be sent via Tracker's "send" method.
