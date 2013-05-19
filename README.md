# Opawesome (oh-pawesome)

Multi-armed bandit optimization testing for rails

## Rad stuff
- A little bit of javascript will ping the rails app when someone first visits to confirm they're not a spider
- Test options can be added/removed from the admin panel at any time
- Users will always see the same option throughout a visit (unless they clear cookies)
- You can exclude yourself from your tests by appending ?opaw_ignore=true to any url when you visit your app (you will have a permanent cookie set, but I recommend doing this to all bookmarks or whatever you use to access your app)

## Things to be aware of
- Users are not prevented from converting multiple times, it is up to you to make sure that you only call opaw_convert! when you need it called, don't just stick it at the top of a controller action (this does allow you to do things like consider 10 page views as a conversion and let people convert repeatedly to choose test options that encourage engagement if you want)
- The Opawesome::Tests controller allows administration of optimization tests, but is not locked down by default. The quickest way to fix this is by creating an initializer that contains the following code:
```ruby
Opawesome::TestsController.class_eval do
  http_basic_authenticate_with :name => "test", :password => "secret"
end
```

## Setup

Add this to your gemfile:

```ruby
gem 'opawesome', :git => 'git://github.com/arehberg/opawesome.git'
```

Add this to your application.js:

```javascript
//= require 'opawesome'
```

## Usage

Selecting a test option:
  - The test will be automatically created in the database the first time this is called
  - The third field is the default value and will be used to create a test option the first time this is called
  - The :test_tag will be used to track conversions for this test, so remember it

```ruby
opaw_select :test_tag, "Default test option value"
```

Tracking a conversion:

```ruby
opaw_convert! :test_tag
```
