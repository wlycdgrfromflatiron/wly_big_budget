# wly's Big Budget
### flexible budgeting for minnows and mavens

Big Budget is a simple budgeting app that helps you track, categorize, and explore your spending through support for item and store prefabs, tags, and multi-item purchases.

## Getting Started
For a quick peek, check out the [preview production version](https://wly-big-budget.herokuapp.com/). Use 'ilya@gmail.com' pw 'ilya', 'eugene@gmail.com' pw 'eugene', or 'willa@gmail.com' pw 'willa' to log in, as new first-party account creation is disabled. Alternatively, you can log in through Amazon. Please be mindful that this is just a demo.

To use and explore Big Budget on your local machine, follow these steps:
* Clone the repo
* Navigate to the project directory in your terminal and run `bundle install` to install the gem (Ruby library) dependencies specified in the Gemlock file
* Run `rails db:migrate` to create the database tables. Check out the docs/ folder for a diagram of the schema. 
* (Optional, but recommended) Run `rails db:seed`. This will create some test data and accounts. Use ilya@gmail.com pw 'ilya', and/or check the db/seeds.rb file for additional details. You can create additional users through the `rails console` as needed. Note that you will need to mark the new user's email as being confirmed, or the email confirmation guard will block you from logging in.
* (Optional) To use the Amazon third-party login option:
    1. Create an application with the [Amazon App Console](https://login.amazon.com/manageApps), as per the [OmniAuth-Amazon](https://github.com/wingrunr21/omniauth-amazon) gem instructions.
    2. Create a '.env' file in the project's root directory. [dotenv-rails](https://github.com/bkeepers/dotenv) uses this file to populate the environment variable hash.
    3. Add the client ID and secret of your Amazon app to the .env file as AMAZON_CLIENT_ID and AMAZON_CLIENT_SECRET
    4. Make extra sure that the .gitignore file includes .env so that you don't accidentally push your private Amazon app credentials to a public repo.
* (Optional, a hassle, but instructive) To create new users through the web interface rather than the console, you'll need to setup a third-party SMTP provider to handle the email confirmation flow. I recommend [Mailgun](https://www.mailgun.com/).
    1. Register and setup an account through Mailgun or another SMTP provider.
    2. Consult config.action_mailer.smtp_settings in config/development.rb and the classes in app/mailers to see what you will need to add to the .env file.
    3. Once again, make sure that .env is part of your .gitignore. Even if you don't plan to push your local work to a public repo, never hard code your private keys or check them into your repo.
* Finally, run `rails s` to start the Rails server and visit the site at http://localhost:3000. If you want to log in with Amazon, which requires https, run `thin start --ssl` instead and use https://localhost:3000. Your browser may give you a warning; ignore it.

## Prerequisites
You'll need to have Ruby installed. If it's not already installed on your system, follow the [official Ruby installation guide](https://www.ruby-lang.org/en/documentation/installation/).

If you're on Windows, I recommend you [install WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10) and use [cmder](http://cmder.net/) instead of the default Ubuntu on Windows terminal.

You'll need Bundler, Ruby's de-facto official package manager, to install the project's dependencies. Check the [Bundler website](https://bundler.io/) for installation instructions and usage details.

For exploring and  editing the code, I recommend [Visual Studio Code](https://code.visualstudio.com/). It is a one-stop solution that has good and growing support for all the languages you might want to use - not just the popular web dev ones.

## Deployment
For free and easy deployment, I suggest Heroku. The app is already configured to use Heroku's preferred PostgreSQL on production. Visit the [Heroku Devcenter](https://devcenter.heroku.com/) to get started.

## Built With
* Rails 5 - web framework
* Bundler - dependency management
* OmniAuth - third-party authentication
* BCrypt - secure passwords
* SASS - CSS variables, nesting, and mixins

## Versioning
For the versions available, see the tags on this repository.

## Authors
Ilya Zarembsky / Project lead / Initial and ongoing design and development

## License 
This project is licensed under the GNU AGPLv3 license - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments
This is a [Flatiron School](https://flatironschool.com/) portfolio project. The school's web developer curriculum greatly helped me get to this point.
I learned how to implement email confirmation with the help of [this tutorial](https://coderwall.com/p/u56rra/ruby-on-rails-user-signup-email-confirmation-tutorial).
I adapted a parameterized filter implementation from [this SO question](https://stackoverflow.com/questions/5507026/before-filter-with-parameters).

