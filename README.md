SpreeSales
==========

Add sales prices to products

Installation
------------

Add spree_sales to your Gemfile:

```ruby
gem 'spree_sales'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_sales:install
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_sales/factories'
```

Forked from <https://github.com/jonathandean/spree-sale-pricing>

Copyright (c) 2014 Gonzalo Moreno <https://github.com/acidlabs/>, released under the New BSD License
