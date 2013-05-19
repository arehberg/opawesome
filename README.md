opawesome
=========

Multi-armed bandit optimization testing for rails


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
