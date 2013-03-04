# DateSelectSeparator

Add separators to data_select on Rails.

## Installation

Add this line to your application's Gemfile:

    gem 'date_select_separator'

And then execute:

    $ bundle

## Usage

    # Add a separator after each select_tag
    <%= f.date_select :birthday, use_month_numbers: true, use_separators: {year: '年', month: '月', day: '日'} %>
    <%= f.datetime_select :birthday, use_month_numbers: true, time_separator: '', use_separators: {year: '年', month: '月', day: '日', hour: '時', minute: '分'} %>
    
    # Add a separator to each option_tag. Month is used a value like ja.date.month_names in config/locales
    <%= f.date_select :birthday, use_separators: {inline: true, year: '年', day: '日'} %>
    <%= f.datetime_select :birthday, time_separator: '', use_separators: {inline: true, year: '年', day: '日', hour: '時', minute: '分'} %>
    
    # Options: html_tag, class_prefix
    <%= f.date_select :birthday, use_month_numbers: true, use_separators: {year: '年', month: '月', day: '日', html_tag: :div, class_prefix: 'prefix'} %>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
