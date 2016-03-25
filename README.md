# DateSelectSeparator [![Build Status](https://travis-ci.org/rono23/date_select_separator.svg?branch=master)](https://travis-ci.org/rono23/date_select_separator)

Add separators to data_select and datetime_select on Ruby on Rails.

![](https://cloud.githubusercontent.com/assets/26753/14019368/c98d9f7e-f215-11e5-8ad4-0c91297640c3.png)

## Installation

Add this line to your application's Gemfile:

    gem 'date_select_separator'

And then execute:

    $ bundle

## Usage

Add translations to your locale file like below.

    ja:
      datetime:
        separators:
          year: 年
          month: 月
          day: 日
          hour: 時
          minute: 分
          second: 秒

Add `use_separators: true` option to data_select or datetime_select.

    # Add a separator after each select_tags
    <%= f.date_select :birthday, use_month_numbers: true, use_separators: true %>
    <%= f.datetime_select :birthday, use_month_numbers: true, time_separator: '', use_separators: true %>

    # Add a separator to each option_tags except month. Month is used a value like ja.data.month_names
    <%= f.date_select :birthday, use_separators: { inline: true } %>
    <%= f.datetime_select :birthday, time_separator: '', use_separators: { inline: true } %>

    # Options: html_tag, class_prefix, translations, wrapper_select_tag etc
    <%= f.date_select :birthday, use_month_numbers: true, use_separators: { html_tag: :div, class_prefix: 'foo_' } %>
    <%= f.date_select :birthday, use_month_numbers: true, use_separators: { year: 'yy', month: 'mm', day: 'dd' } %>
    <%= f.date_select :birthday, use_month_numbers: true, use_separators: { wrapper_select_tag: true } %>
    <%= f.date_select :birthday, use_month_numbers: true, use_separators: { wrapper_select_tag: { html_tag: :span, class_prefix: 'foo_' }} %>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
