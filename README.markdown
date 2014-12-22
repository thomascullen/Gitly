# [Gitly](http://gitly.co)

Grab weekly emails of what open source projects are trending on Github for the languages you're interested in.

![Screenshot](http://f.cl.ly/items/3d0t170m3C3o1h0O2f3q/screenshot.png)

## Installation

Clone the repo locally:

```
git clone git@github.com:bkenny/Gitly.git
```

Enter into the directory

```
cd Gitly
```

Create a new file called .env on route and add the following

```
SENDGRID_PASSWORD=YOUR_SENDGRID_PASSWORD
SENDGRID_USERNAME=YOUR_SENDGRID_USERNAME
GITHUB_CLIENT=YOUR_GITHUB_CLIENT_ID
GITHUB_SECRET=YOUR_GITHUB_SECRET
```

Install dependencies

```
bundle install
```

Create the DB locally and migrate it to the latest (Postgres)

```
rake db:create && rake db:migrate
```

Import the languages as categories

```
rake import_languages
```

You're good to go! Fire up your local server with foreman (uses env variables set in .env)

```
foreman start
```

## Running

First, we store what's trending for the repo's that users have subscribed to with:

``` 
	rake fetch_trending
```

Once the latest GitHub projects are stored, an email is then sent out to the users with the following rake task:

``` 
	rake send_weekly_mail
```