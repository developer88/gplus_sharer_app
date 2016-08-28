# gplus_sharer_app
Simple Heroku-compatible app that shares content to Google+

Based on [share_to_google_plus](https://github.com/developer88/share_to_google_plus) gem.

## Installation

### Heroku

* Create new heroku app
* Add buildpack with `phantomjs`:

```
heroku buildpacks:add https://github.com/stomita/heroku-buildpack-phantomjs
```

Or use [this](https://github.com/stomita/heroku-buildpack-phantomjs) repo's documentation.

* Set up environment valiables:

```
SECRET_CODE - secret kay that will protect your website from unauthorized access
GPLUS_LOGIN - login of google account
GPLUS_PASSWORD - password  of google account
```

* Deploy

### Local or other hostings

* Make sure you have `phantomjs` installed on the machine.
* Or use `Selenium web driver` if available. In this case remove the following line from `index.rb`:

```
config.javascript_driver = :poltergeist
```

* Set up environment valiables (see Heroku's part above)
* Deploy

## Usage

POST <url of your website> with payload:

```
secret - secret key (see SECRET_CODE env variable)
text - text for the post to be published
community - url of community to be published
category - category of the post to be published
link - url for the post to be published
```

## License

Please read [LICENsE](LICENSE) file
