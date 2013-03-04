require "date_select_separator/version"

module ActionView
  module Helpers
    class DateTimeSelector
      def select_month_with_separator
        separators = @options[:use_separators]
        type = :month
        select_tag = select_month_without_separator

        if @options[:use_hidden].blank? && @options[:discard_month].blank? && use_separators?(separators, type) && separators[:inline].blank?
          select_tag += content_tag_for_separator(separators, type)
        end

        select_tag
      end
      alias_method_chain :select_month, :separator

      def build_options_and_select_with_separator(type, selected, options = {})
        separators = @options[:use_separators]

        if use_separators?(separators, type)
          if separators[:inline]
            options.merge!({:use_separator => separators[type]})
            build_select(type, build_options_with_separator(selected, options))
          else
            select_tag = build_select(type, build_options(selected, options))
            select_tag + content_tag_for_separator(separators, type)
          end
        else
          build_options_and_select_without_separator(type, selected, options)
        end
      end
      alias_method_chain :build_options_and_select, :separator

      private
        def use_separators?(separators, type)
          (separators.present? && separators[type].present?)
        end

        def build_options_with_separator(selected, options = {})
          options = {
            leading_zeros: true, ampm: false, use_two_digit_numbers: false, use_separator: false
          }.merge!(options)

          start         = options.delete(:start) || 0
          stop          = options.delete(:end) || 59
          step          = options.delete(:step) || 1
          leading_zeros = options.delete(:leading_zeros)

          select_options = []
          start.step(stop, step) do |i|
            value = leading_zeros ? sprintf("%02d", i) : i
            tag_options = { :value => value }
            tag_options[:selected] = "selected" if selected == i
            text = options[:use_two_digit_numbers] ? sprintf("%02d", i) : value
            text = options[:ampm] ? AMPM_TRANSLATION[i] : text
            text = options[:use_separator] ? text.to_s + options[:use_separator] : text
            select_options << content_tag(:option, text, tag_options)
          end

          (select_options.join("\n") + "\n").html_safe
        end

        def content_tag_for_separator(separators, type)
          separator_tag = separators[:html_tag] || :span
          separator_class = (separators[:class_prefix] ? separators[:class_prefix] : "separator") + "_#{type}"
          content_tag(separator_tag, separators[type], :class => separator_class)
        end
    end
  end
end
