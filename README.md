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





 
