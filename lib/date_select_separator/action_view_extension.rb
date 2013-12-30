module DateSelectSeparator
  module ActionViewExtension
    extend ActiveSupport::Concern

    included do
      def select_month_with_separator
        separators = @options[:use_separators]
        select_tag = select_month_without_separator

        if use_separators?(:month, separators) && !inline_separator?(separators)
          select_tag << separator_tag(:month, separators)
        end

        select_tag
      end
      alias_method_chain :select_month, :separator

      private
      def use_separators?(type, separators)
        discard_type = "discard_#{type}".to_sym
        !@options[:use_hidden] && !@options[discard_type] && separators
      end

      def inline_separator?(separators)
        separators.is_a?(Hash) && separators[:inline]
      end

      def separator_text(type, separators)
        if separators.is_a?(Hash) && separators[type]
          separators[type]
        else
          key = 'datetime.separators.' + type.to_s
          I18n.translate(key, locale: @options[:locale])
        end
      end

      def separator_tag(type, separators)
        default_options = { html_tag: :span, class_prefix: 'separator' }
        options = separators.is_a?(Hash) ? default_options.merge!(separators) : default_options
        text = separator_text(type, separators)
        class_name = options[:class_prefix] + "_#{type}"
        content_tag(options[:html_tag], text, class: class_name) + "\n"
      end

      def build_options_and_select_with_separator(type, selected, options = {})
        separators = @options[:use_separators]

        unless use_separators?(type, separators)
          return build_options_and_select_without_separator(type, selected, options)
        end

        if inline_separator?(separators)
          options.merge!(separator: separator_text(type, separators))
          build_select(type, build_options_with_separator(selected, options))
        else
          build_select(type, build_options(selected, options)) + separator_tag(type, separators)
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
