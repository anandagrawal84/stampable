Stampable gem [![Build Status](https://secure.travis-ci.org/anandagrawal84/stampable.png?branch=master)](http://travis-ci.org/anandagrawal84/stampable)
=============

Overview
--------

The Stampable gem is used to stamp ActiveRecord model with current user. This is a simple gem that stores who modified/created the record in a single field.


Installation
------------

Installation of the plugin can be done using the built in Rails plugin script. Issue the following
command from the root of your Rails application:

    $ ./script/rails plugin install git://github.com/anandagrawal84/stampable.git

or add it to your Gemfile:

    gem 'stampable'

and run `bundle install` to install the new dependency.

Usage
-----
All you need to do is include Stampable module in the ActiveRecord model that you want to stamp.

```ruby
class Blog < ActiveRecord::Base
  include Stampable::Base
end
```

and in case of rails set the current user in application controller

```ruby
class ApplicationController
  before_filter :current_user

  def current_user
    Thread.current['current_user'] = <current user name or id>
  end
end
```

The value saved in current_user (say user name or user id) gets saved in the model that is stampable.

Configuration
-------------
To save the stamp in `touched_by` instead of `modified_by` add following to environment.rb file

```ruby
Stampable::Base.config = {:stamp_field => 'touched_by'}
```

To specify a default user add following

```ruby
Stampable::Base.config = {:default_user => 'robot'}
```
