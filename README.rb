

Heroku is a platform that allows for easy CLI deployment of Ruby applications through integration with github (as well as Node.js, Python, and Java).

First thing's first, you have to have a Heroku account. It's free to sign up.

There is one file that Heroku needs in order to succesfully execute our application that we didn't need to run our app locally. The file we need to create a `Procfile` in the root of our app. Our Procfile just needs the line `web: bundle exec ruby app.rb -p $PORT`.

From there, we're going to follow the instructions on [Heroku's Dev Center](https://devcenter.heroku.com/articles/git).

We already have a git repository with our most recent code pushed up to git, so we can ignore the first few steps.

The first thing we need to do is make sure we're in the directory of our Sinatra application in terminal. From there, we'll enter `heroku create`

This will add a heroku remote to our project. We can enter `git remote -v` to check that both our remote git and remote heroku repositories exist.

Now, we need to send our code stored in git to heroku. We basically have to link the two. 
`git push heroku master`.
This will take a second to run, but we're deployed!

`heroku open` will open our application in the browser, and we can see our handy work.

You'll notice we haven't scheduled our rake task to be run yet. Nothing has told our application to execute it. Heroku has some handy addons, including one called `scheduler`. We're going to use (that)[https://addons.heroku.com/scheduler] free addon to schedule our rake task.

`heroku addons:add scheduler:standard`

So now we can test our rake task in heroku ` heroku run rake check_tweet_time`

Now that that works, we'll need to set the scheduler addon to run the rake task, `heroku addons:open scheduler` will open that interface in the browswer for us.

We'll click `add job`. And then enter `rake check_tweet_time` after the prompt, use 1 dyno, and set it to run every 10 minutes. A dyno is just like a worker, I don't need more than that to execute this.

So now we can tweet and check back in 10 minutes for an email.

So now we have one issue: we left all of our email information and authentication keys for mailgun on github. Our repositories are private right now, so we're not in any danger here, but imagine if our repository was public and it was our real gmail account information. Anyone with a computer could find our information. It's a really stupid way to open yourself up to hackers.

Luckily, Heroku has a great way to [hide these configuaration values](https://devcenter.heroku.com/articles/config-vars).
This is the example they give in their documentation. 
`heroku config:set GITHUB_USERNAME=joesmith`

So let's think about all the values I want to hide:
In messaging.rb my api_key on line 5 and the domain on line 6.
And in config.ru the user_name and password on lines 8 and 9.

So we can fix those immediately:
```
heroku config:set MAILGUN_API_KEY=key-6uiavyyd3nmb9adpaii04drw93y8ymq8
heroku config:set MAILGUN_DOMAIN=sandbox9e40982438de4c218c126056aa8f25ea.mailgun.org
heroku config:set SMTP_USERNAME=postmaster@sandbox9e40982438de4c218c126056aa8f25ea.mailgun.org
heroku config:set SMTP_PASSWORD=7u2yp3x6t6w9
```

`heroku config` will return all the configurations we've set so we can make sure everything is done correctly. So now we need to take those values out of our code

In messaging.rb, our code becomes:
```RUBY
  Mailgun.configure do |config|
    config.api_key = ENV[MAILGUN_API_KEY]
    config.domain  = ENV[MAILGUN_DOMAIN]
  end
```

In config.ru, our code on lines 8 and 9 become:
```
    :user_name => ENV[SMTP_USERNAME],
    :password =>  ENV[SMTP_PASSWORD],
```

Now we can commit those changes to github. The only problem left is that github tracks old commits, so we can still find our passwords and stuff. Let's go ahead and [get rid of those](https://help.github.com/articles/remove-sensitive-data).

We'll actually need to wipe the file from github and it's history, and then re-add it with out heroku environment configs. 

I'm going to make sure I have the documents open before I run the commands in terminal because it will wipe them entirely from memory, both locally and remotely.

This will remove messaging.rb: 
```
 git filter-branch --force --index-filter \
'git rm --cached --ignore-unmatch ./lib/messaging.rb' \
 --prune-empty --tag-name-filter cat -- --all
```

and this will remove config.ru:
```
 git filter-branch --force --index-filter \
'git rm --cached --ignore-unmatch ./config.ru' \
 --prune-empty --tag-name-filter cat -- --all
```

After this, we just resave the files, add, commit, and push them up to github. Voila!

