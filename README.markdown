# [Gitly](http://gitly.co)

Grab weekly emails of what open source projects are trending on Github for the languages you're interested in.

![Screenshot](http://f.cl.ly/items/3d0t170m3C3o1h0O2f3q/screenshot.png)

## Running

Latest GitHub trends are gathered and stored by using the rake task.

``` 
	rake fetch_trending
```

Once the latest GitHub projects are stored an email is then sent out to the users with the following rake task:

``` 
	rake send_weekly_mail
```