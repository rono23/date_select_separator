module DateSelectSeparator
  class Railtie < ::Rails::Railtie
    initializer 'date_select_separator' do |app|
      ActiveSupport.on_load(:action_view) do
        ::ActionView::Helpers::DateTimeSelector.send :include, DateSelectSeparator::ActionViewExtension
      end
    end
  end
end
