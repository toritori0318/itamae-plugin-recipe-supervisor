# Itamae::Plugin::Recipe::Supervisor

Itamae recipe plugin for supervisor.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-recipe-supervisor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-recipe-supervisor

## Usage

### Install
```ruby
include_recipe "supervisor::install"
```


### Generate Config

```ruby
include_recipe "supervisor"

supervisor_service "hoge" do
  command "echo 'hello'"
  notifies :update, "supervisorctl[all]", :delay
end

# for notifies
supervisorctl "all" do
  action :nothing
end
```


### supervisorctl

```ruby
include_recipe "supervisor"

# supervisorctl
supervisorctl "all" do
  action :update
end

# supervisorctl group
supervisorctl_group "webapp" do
  action :restart
end
```


## Contributing

1. Fork it ( https://github.com/toritori0318/itamae-plugin-recipe-supervisor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
