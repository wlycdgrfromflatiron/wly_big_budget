# wly's Big Budget
### flexible budgeting for mavens and minnows

A budgeting app with prefab stores and items, tag-based prefab and purchase classification,
and multi-item purchases. Created in Rails as part of my Flatiron School studies.

There's a Heroku production version you can try at https://wly-big-budget.herokuapp.com/

You will not be able to create new first-party accounts as the email confirmation process goes through a test Mailgun account which is currently locked down to a couple of my test emails. You can use ilya@gmail.com / password "ilya" to log in, or use the Amazon third party login option.

Alternately, you can try the app on your local machine. To do this,
* Clone the repo
* Run rails db:migrate and rails db:seed to create and seed the database
(Note: you will need to use the user accounts provided by the seed file - see note above)
* Run rails s and visit the site at localhost:3000. Use thin start --ssl instead if you want to log in with Amazon, as this requires https.

Copyright Ilya Zarembsky 2018 all rights reserved
