# ActionPanel Plugin for Cordova/PhoneGap 3.0 (iOS and Android)


## Installation

1) Make sure that you have [Node](http://nodejs.org/) and [Cordova CLI](https://github.com/apache/cordova-cli) or [PhoneGap's CLI](https://github.com/mwbrooks/phonegap-cli) installed on your machine.

2) Add a plugin to your project using Cordova CLI:

```bash
cordova plugin add https://github.com/francescobitmunks/cordova-plugin-actionpanel
```
Or using PhoneGap CLI:

```bash
phonegap local plugin add https://github.com/francescobitmunks/cordova-plugin-actionpanel
```

## Usage

```js
var title = "Actions";

var actionCall = {id: "call", text: "Call customer"};
var actionMail = {id: "mail", text: "Mail customer"};

var actions = [actionCall, actionMail];

var cancelButtonText = "Cancel";
            
var options = {
    title: title,
    actions:actions,
    cancelButtonText: cancelButtonText
};

actionPanelPlugin.show(options, 
    function(result){
        alert("upload result: " + result);  
    });
}
```

## Options

### title - iOS, Android
The title label above the Actions.

Type: String

Default: `Actions`

### cancelButtonText - iOS, Android
Label for cancel button.

Type: String

Default: `Cancel`

### actions - iOS, Android
Array for the actions

Type: Array

Default: `[]`

## Requirements
- PhoneGap 3.0 or newer / Cordova 3.0 or newer
- Android 2.3.1 or newer / iOS 5 or newer

## Example

```js
var title = "Actions";

var actionCall = {id: "call", text: "Call customer"};
var actionMail = {id: "mail", text: "Mail customer"};

var actions = [actionCall, actionMail];

var cancelButtonText = "Cancel";
            
var options = {
    title: title,
    actions:actions,
    cancelButtonText: cancelButtonText
};

actionPanelPlugin.show(options, 
    function(result){
        alert("upload result: " + result);  
    });
}
```