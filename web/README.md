# AdSnap Broker API

## Summary
This is the base or "skeleton" application for Ad Service API

## Tracking
Track events in JS with

```
ahoy.track("My browser event", {language: "JavaScript"});

```


Track your first event from a controller with:

```ruby
ahoy.track "My first event", language: "Ruby"
```

### JavaScript, Native Apps, & AMP

Enable the API in `config/initializers/ahoy.rb`:

```ruby
Ahoy.api = true
```

And restart your web server.

### JavaScript

For Rails 7 / Importmap, add to `config/importmap.rb`:

```ruby
pin "ahoy", to: "ahoy.js"
```

And add to `app/javascript/application.js`:

```javascript
import "ahoy"
```

For Rails 6 / Webpacker, run:

```sh
yarn add ahoy.js
```

And add to `app/javascript/packs/application.js`:

```javascript
import ahoy from "ahoy.js"
```

For Rails 5 / Sprockets, add to `app/assets/javascripts/application.js`:

```javascript
//= require ahoy
```

Track an event with:

```javascript
ahoy.track("My second event", {language: "JavaScript"});
```

### Native Apps

Check out [Ahoy iOS](https://github.com/namolnad/ahoy-ios) and [Ahoy 
Android](https://github.com/instacart/ahoy-android).

### Geocoding Setup

To enable geocoding, see the [Geocoding section](#geocoding).

### GDPR Compliance

Ahoy provides a number of options to help with GDPR compliance. See the 
[GDPR section](#gdpr-compliance-1) for more info.

## How It Works

### Visits

When someone visits your website, Ahoy creates a visit with lots of useful 
information.

- **traffic source** - referrer, referring domain, landing page
- **location** - country, region, city, latitude, longitude
- **technology** - browser, OS, device type
- **utm parameters** - source, medium, term, content, campaign

Use the `current_visit` method to access it.

Prevent certain Rails actions from creating visits with:

```ruby
skip_before_action :track_ahoy_visit
```

This is typically useful for APIs. If your entire Rails app is an API, you 
can use:

```ruby
Ahoy.api_only = true
```

You can also defer visit tracking to JavaScript. This is useful for 
preventing bots (that aren’t detected by their user agent) and users with 
cookies disabled from creating a new visit on each request. `:when_needed` 
will create visits server-side only when needed by events, and `false` 
will disable server-side creation completely, discarding events without a 
visit.

```ruby
Ahoy.server_side_visits = :when_needed
```

### Events

Each event has a `name` and `properties`. There are several ways to track 
events.

#### Ruby

```ruby
ahoy.track "Viewed book", title: "Hot, Flat, and Crowded"
```

Track actions automatically with:

```ruby
class ApplicationController < ActionController::Base
  after_action :track_action

  protected

  def track_action
    ahoy.track "Ran action", request.path_parameters
  end
end
```

#### JavaScript

```javascript
ahoy.track("Viewed book", {title: "The World is Flat"});
```

See [Ahoy.js](https://github.com/ankane/ahoy.js) for a complete list of 
features.

#### Native Apps

See the docs for [Ahoy iOS](https://github.com/namolnad/ahoy-ios) and 
[Ahoy Android](https://github.com/instacart/ahoy-android).

#### AMP

```erb
<head>
  <script async custom-element="amp-analytics" 
src="https://cdn.ampproject.org/v0/amp-analytics-0.1.js"></script>
</head>
<body>
  <%= amp_event "Viewed article", title: "Analytics with Rails" %>
</body>
```


## Ingredients
Rails 6.1.4 app, including:
- A selection of useful gems for development and debugging such as
[rubocop](https://github.com/bbatsov/rubocop),
[brakeman](https://github.com/presidentbeef/brakeman),
[awesome_print](https://github.com/awesome-print/awesome_print),
[byebug](https://github.com/deivid-rodriguez/byebug), and
[better_errors](https://github.com/charliesome/better_errors).
- Preconfigured test environment, including:
    - [RSpec](http://rspec.info),
    [FactoryBot](https://github.com/thoughtbot/factory_bot),
    [Capybara](https://github.com/teamcapybara/capybara) configured to work with
    [Selenium](http://www.seleniumhq.org/projects/webdriver/) and
    [ChromeDriver](https://sites.google.com/chromium.org/driver/),
    [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner),
    and [SimpleCov](https://github.com/colszowka/simplecov).
    
- Authentication with the [Devise
gem](https://github.com/plataformatec/devise).
- Preconfigured authorization with the [Pundit
gem](https://github.com/elabs/pundit).
- Internationalization (i18n)
  - All of the base application's strings are in YML dictionaries. This is
  arguably a good practice even for single language applications. Having an
  internationalized base application makes it easier and faster to translate
  elements like Devise, the layout and error messages when creating a single
  language app in a non-English language.
  - Methods for translating enum attributes, including the generation of
  translated options for select boxes. Implemented and documented
- jQuery
- HTML Layouts developed with Bootstrap 3 ([bootstrap-sass
gem](https://github.com/twbs/bootstrap-sass)) to use as a starting point,
including:
    - Navigation bar;
    - Displaying of flash messages and validation errors as Bootstrap alerts;
    - Role-based layout switching: different layouts for guests 
    (unauthenticated users), ordinary users and admins;
- Controller concerns such as `SkipAuthorization`.
- User-friendly error messages (flash) on exceptions such as 
`ActiveRecord::DeleteRestrictionError` and `Pundit::NotAuthorizedErrorand`.
- User management interface for admins in `/admin/users` with pagination
([kaminari gem](https://github.com/kaminari/kaminari)) and searching/filtering 
([ransack
gem](https://github.com/activerecord-hackery/ransack)). Accessible only by 
users with "admin" role. 
- Seed users for the development environment.
- Contact form built with the [mail_form
gem](https://github.com/plataformatec/mail_form).
- E-mails "sent" in the development environment are saved as html files in
`tmp/letter_opener` ([letter_opener
gem](https://github.com/ryanb/letter_opener)).
- The following JavaScript libraries:
  - [Select2](https://github.com/select2/select2) for better select boxes.
  - [SweetAlert2](https://github.com/limonte/sweetalert2) for better JS popups,
  including the replacement of the default `data-confirm` confirmation by a
  better-looking version.
  - ZenUtils: a small JavaScript library consisting of utility functions. See
  [app/assets/javascripts/zen-utils.js](https://github.com/brunofacca/zen-rails-base-app/blob/master/app/assets/javascripts/zen-utils.js).  
- SCSS utility classes for alignment, spacing and font size standardization. See
[app/assets/stylesheets/utility-classes.scss](https://github.com/brunofacca/zen-rails-base-app/blob/master/app/assets/stylesheets/utility-classes.scss).
- High test coverage.

## Development Environment Dependencies
- Ruby 3.0.2
- [Yarn](https://yarnpkg.com/getting-started/install) (requires [Node.js](https://nodejs.org/en/download/))
- Required for running JavaScript-enabled feature specs:
    - [Selenium](http://www.seleniumhq.org/projects/webdriver/)
    - [Google Chrome](https://www.google.com/chrome/)
    - [ChromeDriver](https://sites.google.com/a/chromium.org/chromedriver/): must match your installed version of 
      Google Chrome.
    - [Xvfb](https://www.x.org/archive/X11R7.6/doc/man/man1/Xvfb.1.xhtml) if
    running feature specs on a console-only (no graphical interface) *nix
    environment.


## Usage
Setup tasks such as configuring  time zones, default locale and action mailer
(e.g., SMTP or transactional e-mail service) are not included in the following
steps as they are not specific to this base app.

1. Run `bundle install` to install the gems listed in the `Gemfile` and their 
dependencies.
2. Run `yarn install` to install the front end (JavaScript) packages listed 
in `packages.json` and their dependencies.
3. Configure the databases:
 
    a. If using PostgreSQL, uncomment the `pg` gem from the `Gemfile`. If 
    using MySQL, uncomment the `mysql2` gem.

    b. Uncomment the section of `config/database.yml` corresponding to your 
    chosen DBMS.

    c. If you don't have a DB user (with a password) yet, create one.

    d. Edit the following fields of`config/database.yml`:
        * `database.development`
        * `database.test`
        * `default.username`
        * `default.password`

4. Before attempting to run the application or its test suite, run `rails 
db:create db:migrate db:seed` within the project's root directory. That will 
create the following seed users:
    - Ordinary user: email: `user@test.com` / password: `Devpass1`
    - Admin user: email: `admin@test.com` / password: `Devpass1`
5. Customise the authentication setup. You may want to change one or more of 
the following items: 
    - Aside from Devise's default attributes,
    the `User` model also has `role`, `first_name`, and `last_name` attributes. 
    - Aside from the Devise's default modules, this app also uses
    [Confirmable](http://www.rubydoc.info/github/plataformatec/devise/Devise/Models/Confirmable),
    [Timeoutable](http://www.rubydoc.info/github/plataformatec/devise/Devise/Models/Timeoutable)
    and
    [Lockable](http://www.rubydoc.info/github/plataformatec/devise/Devise/Models/Lockable).
    - Pundit is used for for authorization. The `User` model has an enum
    attribute called `role`. Its possible values are `:user` and `:admin`. The
    default value is `:user`.
6. Customize the application colors by overwriting Bootstrap's variables in 
`app/assets/stylesheets/global.scss`.
7. Remove unused items from the application, such as gems from the `Gemfile`, 
RSpec helpers, custom matchers and shared examples from `spec/support`. 
8. Consider going through the [Ad Rails Security
Checklist](https://github.com/brunofacca/zen-rails-security-checklist) before
deploying the application to production.

## TODO (PRs welcome)
- Dockerize. Set up all development dependencies in the `Dockerfile`.
- Set up continuous integration.
- Fix remaining Rubocop offenses
- Upgrade Bootstrap 3 to Bootstrap 5
- Install and configure the [Secure Headers
gem](https://github.com/twitter/secureheaders).
- Set up CodeClimate with Rubocop, Reek, Brakeman, and ESLint engines.
- Use Yarn instead of gems to install front end libraries such as jQuery and 
Select2.
- Add an asterisk to the labels of required form fields.
- Internationalize and translate the JS front end, mainly `global.js` and 
`ad-utils.js`.
