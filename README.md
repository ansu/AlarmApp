# AlarmApp
###IOS:    A simple Alarm app written in Swift.

It is a simple Alarm/LocalNotiication App where user can add the custom local notification. Local Notification consist of two custom actions Snooze and Stop.
if user press on stop, app remove all pending notifications.

# Architecture

### MVVMR = MVVM + VIPER-Router  

1: Mainly uses the structure from MVVM.  
2: Introduces a component responsible for routing, similar to VIPER.  
3: Aims to keep everything simple, but modular and reusable.  

## Key-Things

1: **Router:** This class takes care routing and all dependecies which are required for any controller or models.  
2: AlarmVC class takes the data from AlarmViewModelling. All business logic lies inside GameViewModelling class. 


## Learning 
In iOS, only specific app types are allowed to run in the background.

1: Apps that play audible content to the user while in the background, such as a music player app
2: Apps that record audio content while in the background
3: Apps that keep users informed of their location at all times, such as a navigation app
4: Apps that support Voice over Internet Protocol (VoIP)
5: Apps that need to download and process new content regularly
6: Apps that receive regular updates from external accessories

Alarm app does not belong to any above categories and can't be run in background. App like sleepcycle alarm app which works smoothly  because it is constantly recording audio through the microphone to monitor the quality of your sleep and belong to 2nd permission.

#Local Notification:
One “solution” to Alamr app is the use of local notifications. A local notification, is like a push notification but it is triggered by an app local to the device.Most of the non-Apple alarm clocks make use of this approach to simulate an alarm if the app is not open.
