module DateSelectSeparator
  module ActionViewExtension
    extend ActiveSupport::Concern

    included do
      def select_month_with_separator
        type = :month
        separator_options = @options[:use_separators]
        select_tag = select_month_without_separator

        if use_separators?(type, separator_options)
          unless inline_separator?(separator_options)
            select_tag << separator_tag(type, separator_options)
          end

          if use_wrapper_select_tag?(separator_options)
            select_tag = wrapper_select_tag(select_tag, type, separator_options)
          end
        end

        select_tag
      end
      alias_method_chain :select_month, :separator

      private
      def use_separators?(type, separator_options)
        discard_type = "discard_#{type}".to_sym
        !@options[:use_hidden] && !@options[discard_type] && separator_options
      end

      def inline_separator?(separator_options)
        separator_options.is_a?(Hash) && separator_options[:inline]
      end

      def use_wrapper_select_tag?(separator_options)
        separator_options.is_a?(Hash) && separator_options[:wrapper_select_tag]
      end

      def wrapper_select_tag(select_tag, type, separator_options)
        default_options = { html_tag: :div, class_prefix: 'wrapper_select' }
        wrapper_options = separator_options[:wrapper_select_tag]
        wrapper_options = wrapper_options.is_a?(Hash) ? default_options.merge(wrapper_options) : default_options
        class_name = wrapper_options[:class_prefix] + "_#{type}"
        content_tag(wrapper_options[:html_tag], select_tag, class: class_name) + "\n"
      end

      def separator_text(type, separator_options)
        if separator_options.is_a?(Hash) && separator_options[type]
          separator_options[type]
        else
          key = 'datetime.separators.' + type.to_s
          I18n.translate(key, locale: @options[:locale], default: '')
        end
      end

      def separator_tag(type, separator_options)
        text = separator_text(type, separator_options)
        return text if text.empty?

        default_options = { html_tag: :span, class_prefix: 'separator' }
        options = separator_options.is_a?(Hash) ? default_options.merge(separator_options) : default_options
        class_name = options[:class_prefix] + "_#{type}"
        content_tag(options[:html_tag], text, class: class_name) + "\n"
      end

      def build_options_and_select_with_separator(type, selected, options = {})
        separator_options = @options[:use_separators]

        unless use_separators?(type, separator_options)
          return build_options_and_select_without_separator(type, selected, options)
        end

        select_tag = if inline_separator?(separator_options)
                       options.merge!(separator: separator_text(type, separator_options))
                       build_select(type, build_options_with_separator(selected, options))
                     else
                       build_select(type, build_options(selected, options)) + separator_tag(type, separator_options)
                     end

        if use_wrapper_select_tag?(separator_options)
          wrapper_select_tag(select_tag, type, separator_options)
        else
          select_tag
        end
      end
      alias_method_chain :build_options_and_select, :separator

      def build_options_with_separator(selected, options = {})
        options = {
          leading_zeros: true, ampm: false, use_two_digit_numbers: false, separator: false
        }.merge!(options)

        start         = options.delete(:start) || 0
        stop          = options.delete(:end) || 59
        step          = options.delete(:step) || 1
        leading_zeros = options.delete(:leading_zeros)

        select_options = []
        start.step(stop, step) do |i|
          value = leading_zeros ? sprintf("%02d", i) : i
          tag_options = { value: value }
          tag_options[:selected] = "selected" if selected == i
          text = options[:use_two_digit_numbers] ? sprintf("%02d", i) : value
          text = options[:ampm] ? AMPM_TRANSLATION[i] : text
          text = options[:separator] ? text.to_s + options[:separator] : text
          select_options << content_tag(:option, text, tag_options)
        end

        (select_options.join("\n") + "\n").html_safe
      end
    end
  end
end
