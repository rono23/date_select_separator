# DateSelectSeparator

Add separators to data_select on Rails.

## Installation

Add this line to your application's Gemfile:

    gem 'date_select_separator'

And then execute:

    $ bundle

## Usage

Add these lines in your locale file like [config/locales/ja.yml](https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/ja.yml):

    ja:
      datetime:
        separators:
          year: 年
          month: 月
          day: 日
          hour: 時
          minute: 分
          second: 秒

And then use ```use_separators: true```:

    # Add a separator after each select_tags
    <%= f.date_select :birthday, use_month_numbers: true, use_separators: true %>
    <%= f.datetime_select :birthday, use_month_numbers: true, time_separator: '', use_separators: true %>
    
    # Add a separator to each option_tags except month. Month is used a value like ja.data.month_names
    <%= f.date_select :birthday, use_separators: {inline: true} %>
    <%= f.datetime_select :birthday, time_separator: '', use_separators: {inline: true} %>
    
    # Options: html_tag, class_prefix etc
    <%= f.date_select :birthday, use_month_numbers: true, use_separators: {html_tag: :div, class_prefix: 'foo'} %>
    <%= f.date_select :birthday, use_month_numbers: true, use_separators: {year: 'yy', month: 'mm', day: 'dd'} %>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
