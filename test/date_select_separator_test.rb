require 'test_helper'

class DateSelectSeparatorTest < ActionView::TestCase
  silence_warnings do
    Post = Struct.new("Post", :id, :written_on, :updated_at)
    Post.class_eval do
      def id
        123
      end
      def id_before_type_cast
        123
      end
      def to_param
        '123'
      end
    end
  end

  def test_select_day
    expected = select_day(Time.mktime(2003, 8, 16))
    expected << %(<span class="separator_day">dd</span>\n).html_safe

    assert_dom_equal expected, select_day(Time.mktime(2003, 8, 16), use_separators: true)
    assert_dom_equal expected, select_day(16, use_separators: true)
  end

  def test_select_day_with_blank
    expected = select_day(Time.mktime(2003, 8, 16), include_blank: true)
    expected << %(<span class="separator_day">dd</span>\n).html_safe

    assert_dom_equal expected, select_day(Time.mktime(2003, 8, 16), include_blank: true, use_separators: true)
    assert_dom_equal expected, select_day(16, include_blank: true, use_separators: true)
  end

  def test_select_day_nil_with_blank
    expected = select_day(nil, include_blank: true)
    expected << %(<span class="separator_day">dd</span>\n).html_safe

    assert_dom_equal expected, select_day(nil, include_blank: true, use_separators: true)
  end

  def test_select_day_with_two_digit_numbers
    expected = select_day(Time.mktime(2011, 8, 2), use_two_digit_numbers: true)
    expected << %(<span class="separator_day">dd</span>\n).html_safe

    assert_dom_equal expected, select_day(Time.mktime(2011, 8, 2), use_two_digit_numbers: true, use_separators: true)
    assert_dom_equal expected, select_day(2, use_two_digit_numbers: true, use_separators: true)
  end

  def test_select_day_with_html_options
    expected = select_day(Time.mktime(2003, 8, 16), {}, class: 'selector')
    expected << %(<span class="separator_day">dd</span>\n).html_safe

    assert_dom_equal expected, select_day(Time.mktime(2003, 8, 16), { use_separators: true }, class: 'selector')
    assert_dom_equal expected, select_day(16, { use_separators: true }, class: 'selector')
  end

  def test_select_day_with_default_prompt
    expected = select_day(16, prompt: true)
    expected << %(<span class="separator_day">dd</span>\n).html_safe

    assert_dom_equal expected, select_day(16, prompt: true, use_separators: true)
  end

  def test_select_day_with_custom_prompt
    expected = select_day(16, prompt: 'Choose day')
    expected << %(<span class="separator_day">dd</span>\n).html_safe

    assert_dom_equal expected, select_day(16, prompt: 'Choose day', use_separators: true)
  end

  def test_select_day_with_inline_custom_separator
    expected = select_day(Time.mktime(2003, 8, 16))
    expected.gsub!('</option>', 'dd</option>')

    assert_dom_equal expected, select_day(Time.mktime(2003, 8, 16), use_separators: { inline: true })
    assert_dom_equal expected, select_day(16, use_separators: { inline: true })
  end

  def test_select_day_with_custom_separator_and_html_tag
    expected = select_day(Time.mktime(2003, 8, 16))
    expected << %(<div class="separator_day">dd</div>\n).html_safe

    assert_dom_equal expected, select_day(Time.mktime(2003, 8, 16), use_separators: { html_tag: :div })
    assert_dom_equal expected, select_day(16, use_separators: { html_tag: :div })
  end

  def test_select_day_with_custom_separator_and_class_prefix
    expected = select_day(Time.mktime(2003, 8, 16))
    expected << %(<span class="foo_day">dd</span>\n).html_safe

    assert_dom_equal expected, select_day(Time.mktime(2003, 8, 16), use_separators: { class_prefix: 'foo_' })
    assert_dom_equal expected, select_day(16, use_separators: { class_prefix: 'foo_' })
  end

  def test_select_day_with_custom_separator_and_translation
    expected = select_day(Time.mktime(2003, 8, 16))
    expected << %(<span class="separator_day">foo</span>\n).html_safe

    assert_dom_equal expected, select_day(Time.mktime(2003, 8, 16), use_separators: { day: 'foo' })
    assert_dom_equal expected, select_day(16, use_separators: { day: 'foo' })
  end

  def test_select_day_with_custom_separator_and_wrapper_select_tag
    expected = %(<div class="wrapper_select_day">\n)
    expected << select_day(Time.mktime(2003, 8, 16))
    expected << %(<span class="separator_day">dd</span>\n).html_safe
    expected << %(</div>\n)

    assert_dom_equal expected, select_day(Time.mktime(2003, 8, 16), use_separators: { wrapper_select_tag: true })
    assert_dom_equal expected, select_day(16, use_separators: { wrapper_select_tag: true })
  end

  def test_select_day_with_custom_separator_and_wrapper_select_tag_with_options
    expected = %(<span class="foo_day">\n)
    expected << select_day(Time.mktime(2003, 8, 16))
    expected << %(<span class="separator_day">dd</span>\n).html_safe
    expected << %(</span>\n)

    assert_dom_equal expected, select_day(Time.mktime(2003, 8, 16), use_separators: { wrapper_select_tag: { html_tag: :span, class_prefix: 'foo_' }})
    assert_dom_equal expected, select_day(16, use_separators: { wrapper_select_tag: { html_tag: :span, class_prefix: 'foo_' }})
  end

  def test_select_month
    expected = select_month(Time.mktime(2003, 8, 16))
    expected << %(<span class="separator_month">mm</span>\n).html_safe

    assert_dom_equal expected, select_month(Time.mktime(2003, 8, 16), use_separators: true)
    assert_dom_equal expected, select_month(8, use_separators: true)
  end

  def test_select_month_with_two_digit_numbers
    expected = select_month(Time.mktime(2003, 8, 16), use_two_digit_numbers: true)
    expected << %(<span class="separator_month">mm</span>\n).html_safe

    assert_dom_equal expected, select_month(Time.mktime(2011, 8, 16), use_two_digit_numbers: true, use_separators: true)
    assert_dom_equal expected, select_month(8, use_two_digit_numbers: true, use_separators: true)
  end

  def test_select_month_with_disabled
    expected = select_month(Time.mktime(2003, 8, 16), disabled: true)
    expected << %(<span class="separator_month">mm</span>\n).html_safe

    assert_dom_equal expected, select_month(Time.mktime(2003, 8, 16), disabled: true, use_separators: true)
    assert_dom_equal expected, select_month(8, disabled: true, use_separators: true)
  end

  def test_select_month_with_field_name_override
    expected = select_month(Time.mktime(2003, 8, 16), field_name: 'mois')
    expected << %(<span class="separator_month">mm</span>\n).html_safe

    assert_dom_equal expected, select_month(Time.mktime(2003, 8, 16), field_name: 'mois', use_separators: true)
    assert_dom_equal expected, select_month(8, field_name: 'mois', use_separators: true)
  end

  def test_select_month_with_blank
    expected = select_month(Time.mktime(2003, 8, 16), include_blank: true)
    expected << %(<span class="separator_month">mm</span>\n).html_safe

    assert_dom_equal expected, select_month(Time.mktime(2003, 8, 16), include_blank: true, use_separators: true)
    assert_dom_equal expected, select_month(8, include_blank: true, use_separators: true)
  end

  def test_select_month_nil_with_blank
    expected = select_month(nil, include_blank: true)
    expected << %(<span class="separator_month">mm</span>\n).html_safe

    assert_dom_equal expected, select_month(nil, include_blank: true, use_separators: true)
  end

  def test_select_month_with_numbers
    expected = select_month(Time.mktime(2003, 8, 16), use_month_numbers: true)
    expected << %(<span class="separator_month">mm</span>\n).html_safe

    assert_dom_equal expected, select_month(Time.mktime(2003, 8, 16), use_month_numbers: true, use_separators: true)
    assert_dom_equal expected, select_month(8, use_month_numbers: true, use_separators: true)
  end

  def test_select_month_with_numbers_and_names
    expected = select_month(Time.mktime(2003, 8, 16), add_month_numbers: true)
    expected << %(<span class="separator_month">mm</span>\n).html_safe

    assert_dom_equal expected, select_month(Time.mktime(2003, 8, 16), add_month_numbers: true, use_separators: true)
    assert_dom_equal expected, select_month(8, add_month_numbers: true, use_separators: true)
  end

  def test_select_month_with_numbers_and_names_with_abbv
    expected = select_month(Time.mktime(2003, 8, 16), add_month_numbers: true, use_short_month: true)
    expected << %(<span class="separator_month">mm</span>\n).html_safe

    assert_dom_equal expected, select_month(Time.mktime(2003, 8, 16), add_month_numbers: true, use_short_month: true, use_separators: true)
    assert_dom_equal expected, select_month(8, add_month_numbers: true, use_short_month: true, use_separators: true)
  end

  def test_select_month_with_abbv
    expected = select_month(Time.mktime(2003, 8, 16), use_short_month: true)
    expected << %(<span class="separator_month">mm</span>\n).html_safe

    assert_dom_equal expected, select_month(Time.mktime(2003, 8, 16), use_short_month: true, use_separators: true)
    assert_dom_equal expected, select_month(8, use_short_month: true, use_separators: true)
  end

  def test_select_month_with_custom_names
    month_names = %w(nil Januar Februar Marts April Maj Juni Juli August September Oktober November December)

    expected = %(<select id="date_month" name="date[month]">\n)
    1.upto(12) { |month| expected << %(<option value="#{month}"#{' selected="selected"' if month == 8}>#{month_names[month]}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    assert_dom_equal expected, select_month(Time.mktime(2003, 8, 16), use_month_names: month_names, use_separators: true)
    assert_dom_equal expected, select_month(8, use_month_names: month_names, use_separators: true)
  end

  def test_select_month_with_zero_indexed_custom_names
    month_names = %w(Januar Februar Marts April Maj Juni Juli August September Oktober November December)

    expected = %(<select id="date_month" name="date[month]">\n)
    1.upto(12) { |month| expected << %(<option value="#{month}"#{' selected="selected"' if month == 8}>#{month_names[month-1]}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    assert_dom_equal expected, select_month(Time.mktime(2003, 8, 16), use_month_names: month_names, use_separators: true)
    assert_dom_equal expected, select_month(8, use_month_names: month_names, use_separators: true)
  end

  def test_select_month_with_hidden
    assert_dom_equal "<input type=\"hidden\" id=\"date_month\" name=\"date[month]\" value=\"8\" />\n", select_month(8, use_hidden: true, use_separators: true)
  end

  def test_select_month_with_hidden_and_field_name
    assert_dom_equal "<input type=\"hidden\" id=\"date_mois\" name=\"date[mois]\" value=\"8\" />\n", select_month(8, use_hidden: true, field_name: 'mois', use_separators: true)
  end

  def test_select_month_with_html_options
    expected = select_month(Time.mktime(2003, 8, 16), {}, class: 'selector', accesskey: 'M')
    expected << %(<span class="separator_month">mm</span>\n).html_safe

    assert_dom_equal expected, select_month(Time.mktime(2003, 8, 16), { use_separators: true }, class: 'selector', accesskey: 'M')
  end

  def test_select_month_with_default_prompt
    expected = select_month(8, prompt: true)
    expected << %(<span class="separator_month">mm</span>\n).html_safe

    assert_dom_equal expected, select_month(8, prompt: true, use_separators: true)
  end

  def test_select_month_with_custom_prompt
    expected = select_month(8, prompt: 'Choose month')
    expected << %(<span class="separator_month">mm</span>\n).html_safe

    assert_dom_equal expected, select_month(8, prompt: 'Choose month', use_separators: true)
  end

  def test_select_month_with_inline_custom_separator
    expected = select_month(Time.mktime(2003, 8, 16))

    assert_dom_equal expected, select_month(Time.mktime(2003, 8, 16), use_separators: { inline: true })
    assert_dom_equal expected, select_month(8, use_separators: { inline: true })
  end

  def test_select_month_with_custom_separator_and_html_tag
    expected = select_month(Time.mktime(2003, 8, 16))
    expected << %(<div class="separator_month">mm</div>\n).html_safe

    assert_dom_equal expected, select_month(Time.mktime(2003, 8, 16), use_separators: { html_tag: :div })
    assert_dom_equal expected, select_month(8, use_separators: { html_tag: :div })
  end

  def test_select_month_with_custom_separator_and_class_prefix
    expected = select_month(Time.mktime(2003, 8, 16))
    expected << %(<span class="foo_month">mm</span>\n).html_safe

    assert_dom_equal expected, select_month(Time.mktime(2003, 8, 16), use_separators: { class_prefix: 'foo_' })
    assert_dom_equal expected, select_month(8, use_separators: { class_prefix: 'foo_' })
  end

  def test_select_month_with_custom_separator_and_translation
    expected = select_month(Time.mktime(2003, 8, 16))
    expected << %(<span class="separator_month">foo</span>\n).html_safe

    assert_dom_equal expected, select_month(Time.mktime(2003, 8, 16), use_separators: { month: 'foo' })
    assert_dom_equal expected, select_month(8, use_separators: { month: 'foo' })
  end

  def test_select_month_with_custom_separator_and_wrapper_select_tag
    expected = %(<div class="wrapper_select_month">\n)
    expected << select_month(Time.mktime(2003, 8, 16))
    expected << %(<span class="separator_month">mm</span>\n).html_safe
    expected << %(</div>\n)

    assert_dom_equal expected, select_month(Time.mktime(2003, 8, 16), use_separators: { wrapper_select_tag: true })
    assert_dom_equal expected, select_month(8, use_separators: { wrapper_select_tag: true })
  end

  def test_select_month_with_custom_separator_and_wrapper_select_tag_with_options
    expected = %(<span class="foo_month">\n)
    expected << select_month(Time.mktime(2003, 8, 16))
    expected << %(<span class="separator_month">mm</span>\n).html_safe
    expected << %(</span>\n)

    assert_dom_equal expected, select_month(Time.mktime(2003, 8, 16), use_separators: { wrapper_select_tag: { html_tag: :span, class_prefix: 'foo_' }})
    assert_dom_equal expected, select_month(8, use_separators: { wrapper_select_tag: { html_tag: :span, class_prefix: 'foo_' }})
  end

  def test_select_year
    expected = select_year(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005)
    expected << %(<span class="separator_year">yy</span>\n).html_safe

    assert_dom_equal expected, select_year(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005, use_separators: true)
    assert_dom_equal expected, select_year(2003, start_year: 2003, end_year: 2005, use_separators: true)
  end

  def test_select_year_with_disabled
    expected = select_year(Time.mktime(2003, 8, 16), disabled: true, start_year: 2003, end_year: 2005)
    expected << %(<span class="separator_year">yy</span>\n).html_safe

    assert_dom_equal expected, select_year(Time.mktime(2003, 8, 16), disabled: true, start_year: 2003, end_year: 2005, use_separators: true)
    assert_dom_equal expected, select_year(2003, disabled: true, start_year: 2003, end_year: 2005, use_separators: true)
  end

  def test_select_year_with_field_name_override
    expected = select_year(2003, start_year: 2003, end_year: 2005, field_name: 'annee')
    expected << %(<span class="separator_year">yy</span>\n).html_safe

    assert_dom_equal expected, select_year(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005, field_name: 'annee', use_separators: true)
    assert_dom_equal expected, select_year(2003, start_year: 2003, end_year: 2005, field_name: 'annee', use_separators: true)
  end

  def test_select_year_with_type_discarding
    expected = select_year(Time.mktime(2003, 8, 16), prefix: "date_year", discard_type: true, start_year: 2003, end_year: 2005)
    expected << %(<span class="separator_year">yy</span>\n).html_safe

    assert_dom_equal expected, select_year(
      Time.mktime(2003, 8, 16), prefix: "date_year", discard_type: true, start_year: 2003, end_year: 2005, use_separators: true)
    assert_dom_equal expected, select_year(
      2003, prefix: "date_year", discard_type: true, start_year: 2003, end_year: 2005, use_separators: true)
  end

  def test_select_year_descending
    expected = select_year(Time.mktime(2005, 8, 16), start_year: 2005, end_year: 2003)
    expected << %(<span class="separator_year">yy</span>\n).html_safe

    assert_dom_equal expected, select_year(Time.mktime(2005, 8, 16), start_year: 2005, end_year: 2003, use_separators: true)
    assert_dom_equal expected, select_year(2005, start_year: 2005, end_year: 2003, use_separators: true)
  end

  def test_select_year_with_hidden
    assert_dom_equal "<input type=\"hidden\" id=\"date_year\" name=\"date[year]\" value=\"2007\" />\n", select_year(2007, use_hidden: true, use_separators: true)
  end

  def test_select_year_with_hidden_and_field_name
    assert_dom_equal "<input type=\"hidden\" id=\"date_anno\" name=\"date[anno]\" value=\"2007\" />\n", select_year(2007, use_hidden: true, field_name: 'anno', use_separators: true)
  end

  def test_select_year_with_html_options
    expected = select_year(Time.mktime(2003, 8, 16), { start_year: 2003, end_year: 2005 }, class: 'selector', accesskey: 'M')
    expected << %(<span class="separator_year">yy</span>\n).html_safe

    assert_dom_equal expected, select_year(Time.mktime(2003, 8, 16), { start_year: 2003, end_year: 2005, use_separators: true }, class: 'selector', accesskey: 'M')
  end

  def test_select_year_with_default_prompt
    expected = select_year(nil, start_year: 2003, end_year: 2005, prompt: true)
    expected << %(<span class="separator_year">yy</span>\n).html_safe

    assert_dom_equal expected, select_year(nil, start_year: 2003, end_year: 2005, prompt: true, use_separators: true)
  end

  def test_select_year_with_custom_prompt
    expected = select_year(nil, start_year: 2003, end_year: 2005, prompt: 'Choose year')
    expected << %(<span class="separator_year">yy</span>\n).html_safe

    assert_dom_equal expected, select_year(nil, start_year: 2003, end_year: 2005, prompt: 'Choose year', use_separators: true)
  end

  def test_select_year_with_inline_custom_separator
    expected = select_year(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005)
    expected.gsub!('</option>', 'yy</option>')

    assert_dom_equal expected, select_year(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005, use_separators: { inline: true })
    assert_dom_equal expected, select_year(2003, start_year: 2003, end_year: 2005, use_separators: { inline: true })
  end

  def test_select_year_with_custom_separator_and_html_tag
    expected = select_year(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005)
    expected << %(<div class="separator_year">yy</div>\n).html_safe

    assert_dom_equal expected, select_year(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005, use_separators: { html_tag: :div })
    assert_dom_equal expected, select_year(2003, start_year: 2003, end_year: 2005, use_separators: { html_tag: :div })
  end

  def test_select_year_with_custom_separator_and_class_prefix
    expected = select_year(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005)
    expected << %(<span class="foo_year">yy</span>\n).html_safe

    assert_dom_equal expected, select_year(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005, use_separators: { class_prefix: 'foo_' })
    assert_dom_equal expected, select_year(2003, start_year: 2003, end_year: 2005, use_separators: { class_prefix: 'foo_' })
  end

  def test_select_year_with_custom_separator_and_translation
    expected = select_year(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005)
    expected << %(<span class="separator_year">foo</span>\n).html_safe

    assert_dom_equal expected, select_year(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005, use_separators: { year: 'foo' })
    assert_dom_equal expected, select_year(2003, start_year: 2003, end_year: 2005, use_separators: { year: 'foo' })
  end

  def test_select_year_with_custom_separator_and_wrapper_select_tag
    expected = %(<div class="wrapper_select_year">\n)
    expected << select_year(Time.mktime(2003, 8, 16))
    expected << %(<span class="separator_year">yy</span>\n).html_safe
    expected << %(</div>\n)

    assert_dom_equal expected, select_year(Time.mktime(2003, 8, 16), use_separators: { wrapper_select_tag: true })
    assert_dom_equal expected, select_year(2003, use_separators: { wrapper_select_tag: true })
  end

  def test_select_year_with_custom_separator_and_wrapper_select_tag_with_options
    expected = %(<span class="foo_year">\n)
    expected << select_year(Time.mktime(2003, 8, 16))
    expected << %(<span class="separator_year">yy</span>\n).html_safe
    expected << %(</span>\n)

    assert_dom_equal expected, select_year(Time.mktime(2003, 8, 16), use_separators: { wrapper_select_tag: { html_tag: :span, class_prefix: 'foo_' }})
    assert_dom_equal expected, select_year(2003, use_separators: { wrapper_select_tag: { html_tag: :span, class_prefix: 'foo_' }})
  end

  def test_select_hour
    expected = select_hour(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<span class="separator_hour">h</span>\n).html_safe

    assert_dom_equal expected, select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: true)
  end

  def test_select_hour_with_ampm
    expected = select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), ampm: true)
    expected << %(<span class="separator_hour">h</span>\n).html_safe

    assert_dom_equal expected, select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), ampm: true, use_separators: true)
  end

  def test_select_hour_with_disabled
    expected = select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), disabled: true)
    expected << %(<span class="separator_hour">h</span>\n).html_safe

    assert_dom_equal expected, select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), disabled: true, use_separators: true)
  end

  def test_select_hour_with_field_name_override
    expected = select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), field_name: 'heure')
    expected << %(<span class="separator_hour">h</span>\n).html_safe

    assert_dom_equal expected, select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), field_name: 'heure', use_separators: true)
  end

  def test_select_hour_with_blank
    expected = select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), include_blank: true)
    expected << %(<span class="separator_hour">h</span>\n).html_safe

    assert_dom_equal expected, select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), include_blank: true, use_separators: true)
  end

  def test_select_hour_nil_with_blank
    expected = select_hour(nil, include_blank: true)
    expected << %(<span class="separator_hour">h</span>\n).html_safe

    assert_dom_equal expected, select_hour(nil, include_blank: true, use_separators: true)
  end

  def test_select_hour_with_html_options
    expected = select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), {}, class: 'selector', accesskey: 'M')
    expected << %(<span class="separator_hour">h</span>\n).html_safe

    assert_dom_equal expected, select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), { use_separators: true }, class: 'selector', accesskey: 'M')
  end

  def test_select_hour_with_default_prompt
    expected = select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), prompt: true)
    expected << %(<span class="separator_hour">h</span>\n).html_safe

    assert_dom_equal expected, select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), prompt: true, use_separators: true)
  end

  def test_select_hour_with_custom_prompt
    expected = select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), prompt: 'Choose hour')
    expected << %(<span class="separator_hour">h</span>\n).html_safe

    assert_dom_equal expected, select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), prompt: 'Choose hour', use_separators: true)
  end

  def test_select_hour_with_inline_custom_separator
    expected = select_hour(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected.gsub!('</option>', 'h</option>')

    assert_dom_equal expected, select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { inline: true })
  end

  def test_select_hour_with_custom_separator_and_html_tag
    expected = select_hour(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<div class="separator_hour">h</div>\n).html_safe

    assert_dom_equal expected, select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { html_tag: :div })
  end

  def test_select_hour_with_custom_separator_and_class_prefix
    expected = select_hour(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<span class="foo_hour">h</span>\n).html_safe

    assert_dom_equal expected, select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { class_prefix: 'foo_' })
  end

  def test_select_hour_with_custom_separator_and_translation
    expected = select_hour(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<span class="separator_hour">foo</span>\n).html_safe

    assert_dom_equal expected, select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { hour: 'foo' })
  end

  def test_select_hour_with_custom_separator_and_wrapper_select_tag
    expected = %(<div class="wrapper_select_hour">\n)
    expected << select_hour(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<span class="separator_hour">h</span>\n).html_safe
    expected << %(</div>\n)

    assert_dom_equal expected, select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { wrapper_select_tag: true })
  end

  def test_select_hour_with_custom_separator_and_wrapper_select_tag_with_options
    expected = %(<span class="foo_hour">\n)
    expected << select_hour(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<span class="separator_hour">h</span>\n).html_safe
    expected << %(</span>\n)

    assert_dom_equal expected, select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { wrapper_select_tag: { html_tag: :span, class_prefix: 'foo_' }})
  end

  def test_select_minute
    expected = select_minute(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<span class="separator_minute">min</span>\n).html_safe

    assert_dom_equal expected, select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: true)
  end

  def test_select_minute_with_disabled
    expected = select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), disabled: true)
    expected << %(<span class="separator_minute">min</span>\n).html_safe

    assert_dom_equal expected, select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), disabled: true, use_separators: true)
  end

  def test_select_minute_with_field_name_override
    expected = select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), field_name: 'minuto')
    expected << %(<span class="separator_minute">min</span>\n).html_safe

    assert_dom_equal expected, select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), field_name: 'minuto', use_separators: true)
  end

  def test_select_minute_with_blank
    expected = select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), include_blank: true)
    expected << %(<span class="separator_minute">min</span>\n).html_safe

    assert_dom_equal expected, select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), include_blank: true, use_separators: true)
  end

  def test_select_minute_with_blank_and_step
    expected = select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), { include_blank: true, minute_step: 15 })
    expected << %(<span class="separator_minute">min</span>\n).html_safe

    assert_dom_equal expected, select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), { include_blank: true, minute_step: 15, use_separators: true })
  end

  def test_select_minute_nil_with_blank
    expected = select_minute(nil, include_blank: true)
    expected << %(<span class="separator_minute">min</span>\n).html_safe

    assert_dom_equal expected, select_minute(nil, include_blank: true, use_separators: true)
  end

  def test_select_minute_nil_with_blank_and_step
    expected = select_minute(nil, { include_blank: true , minute_step: 15 })
    expected << %(<span class="separator_minute">min</span>\n).html_safe

    assert_dom_equal expected, select_minute(nil, { include_blank: true , minute_step: 15, use_separators: true })
  end

  def test_select_minute_with_hidden
    assert_dom_equal "<input type=\"hidden\" id=\"date_minute\" name=\"date[minute]\" value=\"8\" />\n", select_minute(8, use_hidden: true, use_separators: true)
  end

  def test_select_minute_with_hidden_and_field_name
    assert_dom_equal "<input type=\"hidden\" id=\"date_minuto\" name=\"date[minuto]\" value=\"8\" />\n", select_minute(8, use_hidden: true, field_name: 'minuto', use_separators: true)
  end

  def test_select_minute_with_html_options
    expected = select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), {}, class: 'selector', accesskey: 'M')
    expected << %(<span class="separator_minute">min</span>\n).html_safe

    assert_dom_equal expected, select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), { use_separators: true }, class: 'selector', accesskey: 'M')
  end

  def test_select_minute_with_default_prompt
    expected = select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), prompt: true)
    expected << %(<span class="separator_minute">min</span>\n).html_safe

    assert_dom_equal expected, select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), prompt: true, use_separators: true)
  end

  def test_select_minute_with_custom_prompt
    expected = select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), prompt: 'Choose minute')
    expected << %(<span class="separator_minute">min</span>\n).html_safe

    assert_dom_equal expected, select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), prompt: 'Choose minute', use_separators: true)
  end

  def test_select_minute_with_inline_custom_separator
    expected = select_minute(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected.gsub!('</option>', 'min</option>')

    assert_dom_equal expected, select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { inline: true })
  end

  def test_select_minute_with_custom_separator_and_html_tag
    expected = select_minute(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<div class="separator_minute">min</div>\n).html_safe

    assert_dom_equal expected, select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { html_tag: :div })
  end

  def test_select_minute_with_custom_separator_and_class_prefix
    expected = select_minute(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<span class="foo_minute">min</span>\n).html_safe

    assert_dom_equal expected, select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { class_prefix: 'foo_' })
  end

  def test_select_minute_with_custom_separator_and_translation
    expected = select_minute(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<span class="separator_minute">foo</span>\n).html_safe

    assert_dom_equal expected, select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { minute: 'foo' })
  end

  def test_select_minute_with_custom_separator_and_wrapper_select_tag
    expected = %(<div class="wrapper_select_minute">\n)
    expected << select_minute(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<span class="separator_minute">min</span>\n).html_safe
    expected << %(</div>\n)

    assert_dom_equal expected, select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { wrapper_select_tag: true })
  end

  def test_select_minute_with_custom_separator_and_wrapper_select_tag_with_options
    expected = %(<span class="foo_minute">\n)
    expected << select_minute(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<span class="separator_minute">min</span>\n).html_safe
    expected << %(</span>\n)

    assert_dom_equal expected, select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { wrapper_select_tag: { html_tag: :span, class_prefix: 'foo_' }})
  end

  def test_select_second
    expected = select_second(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<span class="separator_second">sec</span>\n).html_safe

    assert_dom_equal expected, select_second(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: true)
  end

  def test_select_second_with_disabled
    expected = select_second(Time.mktime(2003, 8, 16, 8, 4, 18), disabled: true)
    expected << %(<span class="separator_second">sec</span>\n).html_safe

    assert_dom_equal expected, select_second(Time.mktime(2003, 8, 16, 8, 4, 18), disabled: true, use_separators: true)
  end

  def test_select_second_with_field_name_override
    expected = select_second(Time.mktime(2003, 8, 16, 8, 4, 18), field_name: 'segundo')
    expected << %(<span class="separator_second">sec</span>\n).html_safe

    assert_dom_equal expected, select_second(Time.mktime(2003, 8, 16, 8, 4, 18), field_name: 'segundo', use_separators: true)
  end

  def test_select_second_with_blank
    expected = select_second(Time.mktime(2003, 8, 16, 8, 4, 18), include_blank: true)
    expected << %(<span class="separator_second">sec</span>\n).html_safe

    assert_dom_equal expected, select_second(Time.mktime(2003, 8, 16, 8, 4, 18), include_blank: true, use_separators: true)
  end

  def test_select_second_nil_with_blank
    expected = select_second(nil, include_blank: true)
    expected << %(<span class="separator_second">sec</span>\n).html_safe

    assert_dom_equal expected, select_second(nil, include_blank: true, use_separators: true)
  end

  def test_select_second_with_html_options
    expected = select_second(Time.mktime(2003, 8, 16, 8, 4, 18), {}, class: 'selector', accesskey: 'M')
    expected << %(<span class="separator_second">sec</span>\n).html_safe

    assert_dom_equal expected, select_second(Time.mktime(2003, 8, 16, 8, 4, 18), { use_separators: true }, class: 'selector', accesskey: 'M')
  end

  def test_select_second_with_default_prompt
    expected = select_second(Time.mktime(2003, 8, 16, 8, 4, 18), prompt: true)
    expected << %(<span class="separator_second">sec</span>\n).html_safe

    assert_dom_equal expected, select_second(Time.mktime(2003, 8, 16, 8, 4, 18), prompt: true, use_separators: true)
  end

  def test_select_second_with_custom_prompt
    expected = select_second(Time.mktime(2003, 8, 16, 8, 4, 18), prompt: 'Choose seconds')
    expected << %(<span class="separator_second">sec</span>\n).html_safe

    assert_dom_equal expected, select_second(Time.mktime(2003, 8, 16, 8, 4, 18), prompt: 'Choose seconds', use_separators: true)
  end

  def test_select_second_with_inline_custom_separator
    expected = select_second(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected.gsub!('</option>', 'sec</option>')

    assert_dom_equal expected, select_second(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { inline: true })
  end

  def test_select_second_with_custom_separator_and_html_tag
    expected = select_second(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<div class="separator_second">sec</div>\n).html_safe

    assert_dom_equal expected, select_second(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { html_tag: :div })
  end

  def test_select_second_with_custom_separator_and_class_prefix
    expected = select_second(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<span class="foo_second">sec</span>\n).html_safe

    assert_dom_equal expected, select_second(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { class_prefix: 'foo_' })
  end

  def test_select_second_with_custom_separator_and_translation
    expected = select_second(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<span class="separator_second">foo</span>\n).html_safe

    assert_dom_equal expected, select_second(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { second: 'foo' })
  end

  def test_select_second_with_custom_separator_and_wrapper_select_tag
    expected = %(<div class="wrapper_select_second">\n)
    expected << select_second(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<span class="separator_second">sec</span>\n).html_safe
    expected << %(</div>\n)

    assert_dom_equal expected, select_second(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { wrapper_select_tag: true })
  end

  def test_select_second_with_custom_separator_and_wrapper_select_tag_with_options
    expected = %(<span class="foo_second">\n)
    expected << select_second(Time.mktime(2003, 8, 16, 8, 4, 18))
    expected << %(<span class="separator_second">sec</span>\n).html_safe
    expected << %(</span>\n)

    assert_dom_equal expected, select_second(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { wrapper_select_tag: { html_tag: :span, class_prefix: 'foo_' }})
  end

  def test_select_date
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: true)
  end

  def test_select_date_with_too_big_range_between_start_year_and_end_year
    assert_raise(ArgumentError) { select_date(Time.mktime(2003, 8, 16), start_year: 2000, end_year: 20000, prefix: "date[first]", order: [:month, :day, :year], use_separators: true) }
    assert_raise(ArgumentError) { select_date(Time.mktime(2003, 8, 16), start_year: Date.today.year - 100.years, end_year: 2000, prefix: "date[first]", order: [:month, :day, :year], use_separators: true) }
  end

  def test_select_date_can_have_more_then_1000_years_interval_if_forced_via_parameter
    assert_nothing_raised { select_date(Time.mktime(2003, 8, 16), start_year: 2000, end_year: 3100, max_years_allowed: 2000, use_separators: true) }
  end

  def test_select_date_with_order
    expected = %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected <<  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005, prefix: "date[first]", order: [:month, :day, :year], use_separators: true)
  end

  def test_select_date_with_incomplete_order
    expected = %(<input id="date_first_year" name="date[first][year]" type="hidden" value="2003" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" type="hidden" value="8" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" type="hidden" value="1" />\n)

    assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005, prefix: "date[first]", order: [:day], use_separators: true)
  end

  def test_select_date_with_disabled
    expected =  %(<select id="date_first_year" name="date[first][year]" disabled="disabled">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]" disabled="disabled">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]" disabled="disabled">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005, prefix: "date[first]", disabled: true, use_separators: true)
  end

  def test_select_date_with_no_start_year
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    (Date.today.year-5).upto(Date.today.year+1) do |y|
      if y == Date.today.year
        expected << %(<option value="#{y}" selected="selected">#{y}</option>\n)
      else
        expected << %(<option value="#{y}">#{y}</option>\n)
      end
    end
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, select_date(
      Time.mktime(Date.today.year, 8, 16), end_year: Date.today.year+1, prefix: "date[first]", use_separators: true
    )
  end

  def test_select_date_with_no_end_year
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    2003.upto(2008) do |y|
      if y == 2003
        expected << %(<option value="#{y}" selected="selected">#{y}</option>\n)
      else
        expected << %(<option value="#{y}">#{y}</option>\n)
      end
    end
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, select_date(
      Time.mktime(2003, 8, 16), start_year: 2003, prefix: "date[first]", use_separators: true
    )
  end

  def test_select_date_with_no_start_or_end_year
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    (Date.today.year-5).upto(Date.today.year+5) do |y|
      if y == Date.today.year
        expected << %(<option value="#{y}" selected="selected">#{y}</option>\n)
      else
        expected << %(<option value="#{y}">#{y}</option>\n)
      end
    end
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, select_date(
      Time.mktime(Date.today.year, 8, 16), prefix: "date[first]", use_separators: true
    )
  end

  def test_select_date_with_zero_value
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, select_date(0, start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: true)
  end

  def test_select_date_with_zero_value_and_no_start_year
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    (Date.today.year-5).upto(Date.today.year+1) { |y| expected << %(<option value="#{y}">#{y}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, select_date(0, end_year: Date.today.year+1, prefix: "date[first]", use_separators: true)
  end

  def test_select_date_with_zero_value_and_no_end_year
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    last_year = Time.now.year + 5
    2003.upto(last_year) { |y| expected << %(<option value="#{y}">#{y}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, select_date(0, start_year: 2003, prefix: "date[first]", use_separators: true)
  end

  def test_select_date_with_zero_value_and_no_start_and_end_year
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    (Date.today.year-5).upto(Date.today.year+5) { |y| expected << %(<option value="#{y}">#{y}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, select_date(0, prefix: "date[first]", use_separators: true)
  end

  def test_select_date_with_nil_value_and_no_start_and_end_year
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    (Date.today.year-5).upto(Date.today.year+5) { |y| expected << %(<option value="#{y}">#{y}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, select_date(nil, prefix: "date[first]", use_separators: true)
  end

  def test_select_date_with_html_options
    expected =  %(<select id="date_first_year" name="date[first][year]" class="selector">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]" class="selector">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]" class="selector">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), { start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: true }, class: "selector")
  end

  def test_select_date_with_separator
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << " / "

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << " / "

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), { date_separator: " / ", start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: true })
  end

  def test_select_date_with_separator_and_discard_day
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << " / "

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<input type="hidden" id="date_first_day" name="date[first][day]" value="1" />\n)

    assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), { date_separator: " / ", discard_day: true, start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: true })
  end

  def test_select_date_with_separator_discard_month_and_day
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<input type="hidden" id="date_first_month" name="date[first][month]" value="8" />\n)
    expected << %(<input type="hidden" id="date_first_day" name="date[first][day]" value="1" />\n)

    assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), { date_separator: " / ", discard_month: true, discard_day: true, start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: true })
  end

  def test_select_date_with_hidden
    expected =  %(<input id="date_first_year" name="date[first][year]" type="hidden" value="2003"/>\n)
    expected << %(<input id="date_first_month" name="date[first][month]" type="hidden" value="8" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" type="hidden" value="16" />\n)

    assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), { prefix: "date[first]", use_hidden: true, use_separators: true })
    assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), { date_separator: " / ", prefix: "date[first]", use_hidden: true, use_separators: true })
  end

  def test_select_date_with_css_classes_option
    expected =  %(<select id="date_first_year" name="date[first][year]" class="year">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]" class="month">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]" class="day">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), { start_year: 2003, end_year: 2005, prefix: "date[first]", with_css_classes: true, use_separators: true })
  end

  def test_select_date_with_inline_custom_separator
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003yy</option>\n<option value="2004">2004yy</option>\n<option value="2005">2005yy</option>\n)
    expected << "</select>\n"

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1dd</option>\n<option value="2">2dd</option>\n<option value="3">3dd</option>\n<option value="4">4dd</option>\n<option value="5">5dd</option>\n<option value="6">6dd</option>\n<option value="7">7dd</option>\n<option value="8">8dd</option>\n<option value="9">9dd</option>\n<option value="10">10dd</option>\n<option value="11">11dd</option>\n<option value="12">12dd</option>\n<option value="13">13dd</option>\n<option value="14">14dd</option>\n<option value="15">15dd</option>\n<option value="16" selected="selected">16dd</option>\n<option value="17">17dd</option>\n<option value="18">18dd</option>\n<option value="19">19dd</option>\n<option value="20">20dd</option>\n<option value="21">21dd</option>\n<option value="22">22dd</option>\n<option value="23">23dd</option>\n<option value="24">24dd</option>\n<option value="25">25dd</option>\n<option value="26">26dd</option>\n<option value="27">27dd</option>\n<option value="28">28dd</option>\n<option value="29">29dd</option>\n<option value="30">30dd</option>\n<option value="31">31dd</option>\n)
    expected << "</select>\n"

    assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: { inline: true } )
  end

  def test_select_date_with_custom_separator_and_html_tag
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<div class="separator_year">yy</div>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<div class="separator_month">mm</div>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<div class="separator_day">dd</div>\n)

    assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: { html_tag: :div })
  end

  def test_select_date_with_custom_separator_and_class_prefix
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="foo_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="foo_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="foo_day">dd</span>\n)

    assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: { class_prefix: 'foo_' })
  end

  def test_select_date_with_custom_separator_and_translation
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">foo</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">bar</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">baz</span>\n)

    assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: { year: 'foo', month: 'bar', day: 'baz' })
  end

  def test_select_date_with_custom_separator_and_wrapper_select_tag
    expected = %(<div class="wrapper_select_year">\n)
    expected <<  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << %(</div>\n)

    expected << %(<div class="wrapper_select_month">\n)
    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %(</div>\n)

    expected << %(<div class="wrapper_select_day">\n)
    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)
    expected << %(</div>\n)

    assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: { wrapper_select_tag: true })
  end

  def test_select_date_with_custom_separator_and_wrapper_select_tag_with_options
    expected = %(<span class="foo_year">\n)
    expected <<  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << %(</span>\n)

    expected << %(<span class="foo_month">\n)
    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %(</span>\n)

    expected << %(<span class="foo_day">\n)
    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)
    expected << %(</span>\n)

    assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: { wrapper_select_tag: { html_tag: :span, class_prefix: 'foo_' }})
  end

  def test_select_datetime
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %(<select id="date_first_hour" name="date[first][hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_first_minute" name="date[first][minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: true)
  end

  def test_select_datetime_with_ampm
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %(<select id="date_first_hour" name="date[first][hour]">\n)
    expected << %(<option value="00">12 AM</option>\n<option value="01">01 AM</option>\n<option value="02">02 AM</option>\n<option value="03">03 AM</option>\n<option value="04">04 AM</option>\n<option value="05">05 AM</option>\n<option value="06">06 AM</option>\n<option value="07">07 AM</option>\n<option value="08" selected="selected">08 AM</option>\n<option value="09">09 AM</option>\n<option value="10">10 AM</option>\n<option value="11">11 AM</option>\n<option value="12">12 PM</option>\n<option value="13">01 PM</option>\n<option value="14">02 PM</option>\n<option value="15">03 PM</option>\n<option value="16">04 PM</option>\n<option value="17">05 PM</option>\n<option value="18">06 PM</option>\n<option value="19">07 PM</option>\n<option value="20">08 PM</option>\n<option value="21">09 PM</option>\n<option value="22">10 PM</option>\n<option value="23">11 PM</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_first_minute" name="date[first][minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), start_year: 2003, end_year: 2005, prefix: "date[first]", ampm: true, use_separators: true)
  end

  def test_select_datetime_with_separators
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %(<select id="date_first_hour" name="date[first][hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_first_minute" name="date[first][minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), start_year: 2003, end_year: 2005, prefix: "date[first]", datetime_separator: ' &mdash; ', time_separator: ' : ', use_separators: true)
  end

  def test_select_datetime_with_nil_value_and_no_start_and_end_year
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    (Date.today.year-5).upto(Date.today.year+5) { |y| expected << %(<option value="#{y}">#{y}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %(<select id="date_first_hour" name="date[first][hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_first_minute" name="date[first][minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, select_datetime(nil, prefix: "date[first]", use_separators: true)
  end

  def test_select_datetime_with_html_options
    expected =  %(<select id="date_first_year" name="date[first][year]" class="selector">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]" class="selector">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]" class="selector">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %(<select id="date_first_hour" name="date[first][hour]" class="selector">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_first_minute" name="date[first][minute]" class="selector">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), { start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: true }, class: 'selector')
  end

  def test_select_datetime_with_all_separators
    expected =  %(<select id="date_first_year" name="date[first][year]" class="selector">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << "/"

    expected << %(<select id="date_first_month" name="date[first][month]" class="selector">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << "/"

    expected << %(<select id="date_first_day" name="date[first][day]" class="selector">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << "&mdash;"

    expected << %(<select id="date_first_hour" name="date[first][hour]" class="selector">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << ":"

    expected << %(<select id="date_first_minute" name="date[first][minute]" class="selector">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), { datetime_separator: "&mdash;", date_separator: "/", time_separator: ":", start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: true }, class: 'selector')
  end

  def test_select_datetime_should_work_with_date
    assert_nothing_raised { select_datetime(Date.today, use_separators: true) }
  end

  def test_select_datetime_with_default_prompt
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="">Year</option>\n<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="">Month</option>\n<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="">Day</option>\n<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %(<select id="date_first_hour" name="date[first][hour]">\n)
    expected << %(<option value="">Hour</option>\n<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_first_minute" name="date[first][minute]">\n)
    expected << %(<option value="">Minute</option>\n<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), start_year: 2003, end_year: 2005, prefix: "date[first]", prompt: true, use_separators: true)
  end

  def test_select_datetime_with_custom_prompt
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="">Choose year</option>\n<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="">Choose month</option>\n<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="">Choose day</option>\n<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %(<select id="date_first_hour" name="date[first][hour]">\n)
    expected << %(<option value="">Choose hour</option>\n<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_first_minute" name="date[first][minute]">\n)
    expected << %(<option value="">Choose minute</option>\n<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), start_year: 2003, end_year: 2005, prefix: "date[first]",
      prompt: { day: 'Choose day', month: 'Choose month', year: 'Choose year', hour: 'Choose hour', minute: 'Choose minute' }, use_separators: true)
  end

  def test_select_datetime_with_custom_hours
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="">Choose year</option>\n<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="">Choose month</option>\n<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="">Choose day</option>\n<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %(<select id="date_first_hour" name="date[first][hour]">\n)
    expected << %(<option value="">Choose hour</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_first_minute" name="date[first][minute]">\n)
    expected << %(<option value="">Choose minute</option>\n<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), start_year: 2003, end_year: 2005, start_hour: 1, end_hour: 9, prefix: "date[first]",
      prompt: { day: 'Choose day', month: 'Choose month', year: 'Choose year', hour: 'Choose hour', minute: 'Choose minute' }, use_separators: true)
  end

  def test_select_datetime_with_hidden
    expected =  %(<input id="date_first_year" name="date[first][year]" type="hidden" value="2003" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" type="hidden" value="8" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" type="hidden" value="16" />\n)
    expected << %(<input id="date_first_hour" name="date[first][hour]" type="hidden" value="8" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" type="hidden" value="4" />\n)

    assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), prefix: "date[first]", use_hidden: true, use_separators: true)
    assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), datetime_separator: "&mdash;", date_separator: "/",
      time_separator: ":", prefix: "date[first]", use_hidden: true, use_separators: true)
  end

  def test_select_datetime_with_inline_custom_separator
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003yy</option>\n<option value="2004">2004yy</option>\n<option value="2005">2005yy</option>\n)
    expected << "</select>\n"

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1dd</option>\n<option value="2">2dd</option>\n<option value="3">3dd</option>\n<option value="4">4dd</option>\n<option value="5">5dd</option>\n<option value="6">6dd</option>\n<option value="7">7dd</option>\n<option value="8">8dd</option>\n<option value="9">9dd</option>\n<option value="10">10dd</option>\n<option value="11">11dd</option>\n<option value="12">12dd</option>\n<option value="13">13dd</option>\n<option value="14">14dd</option>\n<option value="15">15dd</option>\n<option value="16" selected="selected">16dd</option>\n<option value="17">17dd</option>\n<option value="18">18dd</option>\n<option value="19">19dd</option>\n<option value="20">20dd</option>\n<option value="21">21dd</option>\n<option value="22">22dd</option>\n<option value="23">23dd</option>\n<option value="24">24dd</option>\n<option value="25">25dd</option>\n<option value="26">26dd</option>\n<option value="27">27dd</option>\n<option value="28">28dd</option>\n<option value="29">29dd</option>\n<option value="30">30dd</option>\n<option value="31">31dd</option>\n)
    expected << "</select>\n"

    expected << " &mdash; "

    expected << %(<select id="date_first_hour" name="date[first][hour]">\n)
    expected << %(<option value="00">00h</option>\n<option value="01">01h</option>\n<option value="02">02h</option>\n<option value="03">03h</option>\n<option value="04">04h</option>\n<option value="05">05h</option>\n<option value="06">06h</option>\n<option value="07">07h</option>\n<option value="08" selected="selected">08h</option>\n<option value="09">09h</option>\n<option value="10">10h</option>\n<option value="11">11h</option>\n<option value="12">12h</option>\n<option value="13">13h</option>\n<option value="14">14h</option>\n<option value="15">15h</option>\n<option value="16">16h</option>\n<option value="17">17h</option>\n<option value="18">18h</option>\n<option value="19">19h</option>\n<option value="20">20h</option>\n<option value="21">21h</option>\n<option value="22">22h</option>\n<option value="23">23h</option>\n)
    expected << "</select>\n"

    expected << " : "

    expected << %(<select id="date_first_minute" name="date[first][minute]">\n)
    expected << %(<option value="00">00min</option>\n<option value="01">01min</option>\n<option value="02">02min</option>\n<option value="03">03min</option>\n<option value="04" selected="selected">04min</option>\n<option value="05">05min</option>\n<option value="06">06min</option>\n<option value="07">07min</option>\n<option value="08">08min</option>\n<option value="09">09min</option>\n<option value="10">10min</option>\n<option value="11">11min</option>\n<option value="12">12min</option>\n<option value="13">13min</option>\n<option value="14">14min</option>\n<option value="15">15min</option>\n<option value="16">16min</option>\n<option value="17">17min</option>\n<option value="18">18min</option>\n<option value="19">19min</option>\n<option value="20">20min</option>\n<option value="21">21min</option>\n<option value="22">22min</option>\n<option value="23">23min</option>\n<option value="24">24min</option>\n<option value="25">25min</option>\n<option value="26">26min</option>\n<option value="27">27min</option>\n<option value="28">28min</option>\n<option value="29">29min</option>\n<option value="30">30min</option>\n<option value="31">31min</option>\n<option value="32">32min</option>\n<option value="33">33min</option>\n<option value="34">34min</option>\n<option value="35">35min</option>\n<option value="36">36min</option>\n<option value="37">37min</option>\n<option value="38">38min</option>\n<option value="39">39min</option>\n<option value="40">40min</option>\n<option value="41">41min</option>\n<option value="42">42min</option>\n<option value="43">43min</option>\n<option value="44">44min</option>\n<option value="45">45min</option>\n<option value="46">46min</option>\n<option value="47">47min</option>\n<option value="48">48min</option>\n<option value="49">49min</option>\n<option value="50">50min</option>\n<option value="51">51min</option>\n<option value="52">52min</option>\n<option value="53">53min</option>\n<option value="54">54min</option>\n<option value="55">55min</option>\n<option value="56">56min</option>\n<option value="57">57min</option>\n<option value="58">58min</option>\n<option value="59">59min</option>\n)
    expected << "</select>\n"

    assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: { inline: true })
  end

  def test_select_datetime_with_custom_separator_and_html_tag
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<div class="separator_year">yy</div>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<div class="separator_month">mm</div>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<div class="separator_day">dd</div>\n)

    expected << " &mdash; "

    expected << %(<select id="date_first_hour" name="date[first][hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<div class="separator_hour">h</div>\n)

    expected << " : "

    expected << %(<select id="date_first_minute" name="date[first][minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<div class="separator_minute">min</div>\n)

    assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: { html_tag: :div })
  end

  def test_select_datetime_with_custom_separator_and_class_prefix
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="foo_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="foo_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="foo_day">dd</span>\n)

    expected << " &mdash; "

    expected << %(<select id="date_first_hour" name="date[first][hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="foo_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_first_minute" name="date[first][minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="foo_minute">min</span>\n)

    assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: { class_prefix: 'foo_' })
  end

  def test_select_datetime_with_custom_separator_and_translation
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">foo</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">bar</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">baz</span>\n)

    expected << " &mdash; "

    expected << %(<select id="date_first_hour" name="date[first][hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">hoge</span>\n)

    expected << " : "

    expected << %(<select id="date_first_minute" name="date[first][minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">fuga</span>\n)

    assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: { year: 'foo', month: 'bar', day: 'baz', hour: 'hoge', minute: 'fuga' })
  end

  def test_select_datetime_with_custom_separator_and_wrapper_select_tag
    expected = %(<div class="wrapper_select_year">\n)
    expected <<  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << %(</div>\n)

    expected << %(<div class="wrapper_select_month">\n)
    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %(</div>\n)

    expected << %(<div class="wrapper_select_day">\n)
    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)
    expected << %(</div>\n)

    expected << " &mdash; "

    expected << %(<div class="wrapper_select_hour">\n)
    expected << %(<select id="date_first_hour" name="date[first][hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << %(</div>\n)

    expected << " : "

    expected << %(<div class="wrapper_select_minute">\n)
    expected << %(<select id="date_first_minute" name="date[first][minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)
    expected << %(</div>\n)

    assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: { wrapper_select_tag: true })
  end

  def test_select_datetime_with_custom_separator_and_wrapper_select_tag_with_options
    expected = %(<span class="foo_year">\n)
    expected <<  %(<select id="date_first_year" name="date[first][year]">\n)
    expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << %(</span>\n)

    expected << %(<span class="foo_month">\n)
    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %(</span>\n)

    expected << %(<span class="foo_day">\n)
    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)
    expected << %(</span>\n)

    expected << " &mdash; "

    expected << %(<span class="foo_hour">\n)
    expected << %(<select id="date_first_hour" name="date[first][hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << %(</span>\n)

    expected << " : "

    expected << %(<span class="foo_minute">\n)
    expected << %(<select id="date_first_minute" name="date[first][minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)
    expected << %(</span>\n)

    assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: { wrapper_select_tag: { html_tag: :span, class_prefix: 'foo_' }})
  end

  def test_select_time
    expected = %(<input name="date[year]" id="date_year" value="2003" type="hidden" />\n)
    expected << %(<input name="date[month]" id="date_month" value="8" type="hidden" />\n)
    expected << %(<input name="date[day]" id="date_day" value="16" type="hidden" />\n)

    expected << %(<select id="date_hour" name="date[hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_minute" name="date[minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: true)
    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), include_seconds: false, use_separators: true)
  end

  def test_select_time_with_ampm
    expected = %(<input name="date[year]" id="date_year" value="2003" type="hidden" />\n)
    expected << %(<input name="date[month]" id="date_month" value="8" type="hidden" />\n)
    expected << %(<input name="date[day]" id="date_day" value="16" type="hidden" />\n)

    expected << %(<select id="date_hour" name="date[hour]">\n)
    expected << %(<option value="00">12 AM</option>\n<option value="01">01 AM</option>\n<option value="02">02 AM</option>\n<option value="03">03 AM</option>\n<option value="04">04 AM</option>\n<option value="05">05 AM</option>\n<option value="06">06 AM</option>\n<option value="07">07 AM</option>\n<option value="08" selected="selected">08 AM</option>\n<option value="09">09 AM</option>\n<option value="10">10 AM</option>\n<option value="11">11 AM</option>\n<option value="12">12 PM</option>\n<option value="13">01 PM</option>\n<option value="14">02 PM</option>\n<option value="15">03 PM</option>\n<option value="16">04 PM</option>\n<option value="17">05 PM</option>\n<option value="18">06 PM</option>\n<option value="19">07 PM</option>\n<option value="20">08 PM</option>\n<option value="21">09 PM</option>\n<option value="22">10 PM</option>\n<option value="23">11 PM</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_minute" name="date[minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), include_seconds: false, ampm: true, use_separators: true)
  end

  def test_select_time_with_separator
    expected = %(<input name="date[year]" id="date_year" value="2003" type="hidden" />\n)
    expected << %(<input name="date[month]" id="date_month" value="8" type="hidden" />\n)
    expected << %(<input name="date[day]" id="date_day" value="16" type="hidden" />\n)
    expected << %(<select id="date_hour" name="date[hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_minute" name="date[minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), time_separator: ' : ', use_separators: true)
    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), time_separator: ' : ', include_seconds: false, use_separators: true)
  end

  def test_select_time_with_seconds
    expected = %(<input name="date[year]" id="date_year" value="2003" type="hidden" />\n)
    expected << %(<input name="date[month]" id="date_month" value="8" type="hidden" />\n)
    expected << %(<input name="date[day]" id="date_day" value="16" type="hidden" />\n)

    expected << %(<select id="date_hour" name="date[hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << ' : '

    expected << %(<select id="date_minute" name="date[minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    expected << ' : '

    expected << %(<select id="date_second" name="date[second]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18" selected="selected">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_second">sec</span>\n)

    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), include_seconds: true, use_separators: true)
  end

  def test_select_time_with_seconds_and_separator
    expected = %(<input name="date[year]" id="date_year" value="2003" type="hidden" />\n)
    expected << %(<input name="date[month]" id="date_month" value="8" type="hidden" />\n)
    expected << %(<input name="date[day]" id="date_day" value="16" type="hidden" />\n)

    expected << %(<select id="date_hour" name="date[hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_minute" name="date[minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    expected << " : "

    expected << %(<select id="date_second" name="date[second]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18" selected="selected">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_second">sec</span>\n)

    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), include_seconds: true, time_separator: ' : ', use_separators: true)
  end

  def test_select_time_with_html_options
    expected = %(<input name="date[year]" id="date_year" value="2003" type="hidden" />\n)
    expected << %(<input name="date[month]" id="date_month" value="8" type="hidden" />\n)
    expected << %(<input name="date[day]" id="date_day" value="16" type="hidden" />\n)

    expected << %(<select id="date_hour" name="date[hour]" class="selector">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_minute" name="date[minute]" class="selector">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), { use_separators: true }, class: 'selector')
    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), { include_seconds: false, use_separators: true }, class: 'selector')
  end

  def test_select_time_should_work_with_date
    assert_nothing_raised { select_time(Date.today, use_separators: true) }
  end

  def test_select_time_with_default_prompt
    expected = %(<input name="date[year]" id="date_year" value="2003" type="hidden" />\n)
    expected << %(<input name="date[month]" id="date_month" value="8" type="hidden" />\n)
    expected << %(<input name="date[day]" id="date_day" value="16" type="hidden" />\n)

    expected << %(<select id="date_hour" name="date[hour]">\n)
    expected << %(<option value="">Hour</option>\n<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_minute" name="date[minute]">\n)
    expected << %(<option value="">Minute</option>\n<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    expected << " : "

    expected << %(<select id="date_second" name="date[second]">\n)
    expected << %(<option value="">Seconds</option>\n<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18" selected="selected">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_second">sec</span>\n)

    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), include_seconds: true, prompt: true, use_separators: true)
  end

  def test_select_time_with_custom_prompt
    expected = %(<input name="date[year]" id="date_year" value="2003" type="hidden" />\n)
    expected << %(<input name="date[month]" id="date_month" value="8" type="hidden" />\n)
    expected << %(<input name="date[day]" id="date_day" value="16" type="hidden" />\n)

    expected << %(<select id="date_hour" name="date[hour]">\n)
    expected << %(<option value="">Choose hour</option>\n<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_minute" name="date[minute]">\n)
    expected << %(<option value="">Choose minute</option>\n<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    expected << " : "

    expected << %(<select id="date_second" name="date[second]">\n)
    expected << %(<option value="">Choose seconds</option>\n<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18" selected="selected">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_second">sec</span>\n)

    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), include_seconds: true,
      prompt: { hour: 'Choose hour', minute: 'Choose minute', second: 'Choose seconds' }, use_separators: true)
  end

  def test_select_time_with_hidden
    expected =  %(<input id="date_first_year" name="date[first][year]" type="hidden" value="2003" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" type="hidden" value="8" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" type="hidden" value="16" />\n)
    expected << %(<input id="date_first_hour" name="date[first][hour]" type="hidden" value="8" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" type="hidden" value="4" />\n)

    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), prefix: "date[first]", use_hidden: true, use_separators: true)
    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), time_separator: ":", prefix: "date[first]", use_hidden: true, use_separators: true)
  end

  def test_select_time_with_inline_custom_separator
    expected = %(<input name="date[year]" id="date_year" value="2003" type="hidden" />\n)
    expected << %(<input name="date[month]" id="date_month" value="8" type="hidden" />\n)
    expected << %(<input name="date[day]" id="date_day" value="16" type="hidden" />\n)

    expected << %(<select id="date_hour" name="date[hour]">\n)
    expected << %(<option value="00">00h</option>\n<option value="01">01h</option>\n<option value="02">02h</option>\n<option value="03">03h</option>\n<option value="04">04h</option>\n<option value="05">05h</option>\n<option value="06">06h</option>\n<option value="07">07h</option>\n<option value="08" selected="selected">08h</option>\n<option value="09">09h</option>\n<option value="10">10h</option>\n<option value="11">11h</option>\n<option value="12">12h</option>\n<option value="13">13h</option>\n<option value="14">14h</option>\n<option value="15">15h</option>\n<option value="16">16h</option>\n<option value="17">17h</option>\n<option value="18">18h</option>\n<option value="19">19h</option>\n<option value="20">20h</option>\n<option value="21">21h</option>\n<option value="22">22h</option>\n<option value="23">23h</option>\n)
    expected << "</select>\n"

    expected << " : "

    expected << %(<select id="date_minute" name="date[minute]">\n)
    expected << %(<option value="00">00min</option>\n<option value="01">01min</option>\n<option value="02">02min</option>\n<option value="03">03min</option>\n<option value="04" selected="selected">04min</option>\n<option value="05">05min</option>\n<option value="06">06min</option>\n<option value="07">07min</option>\n<option value="08">08min</option>\n<option value="09">09min</option>\n<option value="10">10min</option>\n<option value="11">11min</option>\n<option value="12">12min</option>\n<option value="13">13min</option>\n<option value="14">14min</option>\n<option value="15">15min</option>\n<option value="16">16min</option>\n<option value="17">17min</option>\n<option value="18">18min</option>\n<option value="19">19min</option>\n<option value="20">20min</option>\n<option value="21">21min</option>\n<option value="22">22min</option>\n<option value="23">23min</option>\n<option value="24">24min</option>\n<option value="25">25min</option>\n<option value="26">26min</option>\n<option value="27">27min</option>\n<option value="28">28min</option>\n<option value="29">29min</option>\n<option value="30">30min</option>\n<option value="31">31min</option>\n<option value="32">32min</option>\n<option value="33">33min</option>\n<option value="34">34min</option>\n<option value="35">35min</option>\n<option value="36">36min</option>\n<option value="37">37min</option>\n<option value="38">38min</option>\n<option value="39">39min</option>\n<option value="40">40min</option>\n<option value="41">41min</option>\n<option value="42">42min</option>\n<option value="43">43min</option>\n<option value="44">44min</option>\n<option value="45">45min</option>\n<option value="46">46min</option>\n<option value="47">47min</option>\n<option value="48">48min</option>\n<option value="49">49min</option>\n<option value="50">50min</option>\n<option value="51">51min</option>\n<option value="52">52min</option>\n<option value="53">53min</option>\n<option value="54">54min</option>\n<option value="55">55min</option>\n<option value="56">56min</option>\n<option value="57">57min</option>\n<option value="58">58min</option>\n<option value="59">59min</option>\n)
    expected << "</select>\n"

    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { inline: true })
    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), include_seconds: false, use_separators: { inline: true })
  end

  def test_select_time_with_custom_separator_and_html_tag
    expected = %(<input name="date[year]" id="date_year" value="2003" type="hidden" />\n)
    expected << %(<input name="date[month]" id="date_month" value="8" type="hidden" />\n)
    expected << %(<input name="date[day]" id="date_day" value="16" type="hidden" />\n)

    expected << %(<select id="date_hour" name="date[hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<div class="separator_hour">h</div>\n)

    expected << " : "

    expected << %(<select id="date_minute" name="date[minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<div class="separator_minute">min</div>\n)

    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { html_tag: :div })
    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), include_seconds: false, use_separators: { html_tag: :div })
  end

  def test_select_time_with_custom_separator_and_class_prefix
    expected = %(<input name="date[year]" id="date_year" value="2003" type="hidden" />\n)
    expected << %(<input name="date[month]" id="date_month" value="8" type="hidden" />\n)
    expected << %(<input name="date[day]" id="date_day" value="16" type="hidden" />\n)

    expected << %(<select id="date_hour" name="date[hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="foo_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_minute" name="date[minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="foo_minute">min</span>\n)

    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { class_prefix: 'foo_' })
    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), include_seconds: false, use_separators: { class_prefix: 'foo_' })
  end

  def test_select_time_with_custom_separator_and_translation
    expected = %(<input name="date[year]" id="date_year" value="2003" type="hidden" />\n)
    expected << %(<input name="date[month]" id="date_month" value="8" type="hidden" />\n)
    expected << %(<input name="date[day]" id="date_day" value="16" type="hidden" />\n)

    expected << %(<select id="date_hour" name="date[hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">hoge</span>\n)

    expected << " : "

    expected << %(<select id="date_minute" name="date[minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">fuga</span>\n)

    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { hour: 'hoge', minute: 'fuga' })
    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), include_seconds: false, use_separators: { hour: 'hoge', minute: 'fuga' })
  end

  def test_select_time_with_custom_separator_and_wrapper_select_tag
    expected = %(<input name="date[year]" id="date_year" value="2003" type="hidden" />\n)
    expected << %(<input name="date[month]" id="date_month" value="8" type="hidden" />\n)
    expected << %(<input name="date[day]" id="date_day" value="16" type="hidden" />\n)

    expected << %(<div class="wrapper_select_hour">\n)
    expected << %(<select id="date_hour" name="date[hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << %(</div>\n)

    expected << " : "

    expected << %(<div class="wrapper_select_minute">\n)
    expected << %(<select id="date_minute" name="date[minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)
    expected << %(</div>\n)

    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { wrapper_select_tag: true })
    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), include_seconds: false, use_separators: { wrapper_select_tag: true })
  end

  def test_select_time_with_custom_separator_and_wrapper_select_tag_with_options
    expected = %(<input name="date[year]" id="date_year" value="2003" type="hidden" />\n)
    expected << %(<input name="date[month]" id="date_month" value="8" type="hidden" />\n)
    expected << %(<input name="date[day]" id="date_day" value="16" type="hidden" />\n)

    expected << %(<span class="foo_hour">\n)
    expected << %(<select id="date_hour" name="date[hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << %(</span>\n)

    expected << " : "

    expected << %(<span class="foo_minute">\n)
    expected << %(<select id="date_minute" name="date[minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)
    expected << %(</span>\n)

    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: { wrapper_select_tag: { html_tag: :span, class_prefix: 'foo_' }})
    assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), include_seconds: false, use_separators: { wrapper_select_tag: { html_tag: :span, class_prefix: 'foo_' }})
  end

  def test_date_select
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", use_separators: true)
  end

  def test_date_select_with_selected
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option selected="selected" value="2004">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7" selected="selected">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10" selected="selected">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", selected: Date.new(2004, 07, 10), use_separators: true)
  end

  def test_date_select_with_selected_nil
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = '<input id="post_written_on_1i" name="post[written_on(1i)]" type="hidden" value="1"/>' + "\n"

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value=""></option>\n<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << %{<option value=""></option>\n<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", include_blank: true, discard_year: true, selected: nil, use_separators: true)
  end

  def test_date_select_without_day
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = "<input type=\"hidden\" id=\"post_written_on_3i\" name=\"post[written_on(3i)]\" value=\"1\" />\n"

    expected <<  %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", order: [ :month, :year ], use_separators: true)
  end

  def test_date_select_without_day_and_month
    @post = Post.new
    @post.written_on = Date.new(2004, 2, 29)

    expected = "<input type=\"hidden\" id=\"post_written_on_2i\" name=\"post[written_on(2i)]\" value=\"2\" />\n"
    expected << "<input type=\"hidden\" id=\"post_written_on_3i\" name=\"post[written_on(3i)]\" value=\"1\" />\n"

    expected << %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", order: [ :year ], use_separators: true)
  end

  def test_date_select_without_day_with_separator
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = "<input type=\"hidden\" id=\"post_written_on_3i\" name=\"post[written_on(3i)]\" value=\"1\" />\n"

    expected <<  %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << "/"

    expected << %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", date_separator: '/', order: [ :month, :year ], use_separators: true)
  end

  def test_date_select_without_day_and_with_disabled_html_option
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = "<input type=\"hidden\" id=\"post_written_on_3i\" disabled=\"disabled\" name=\"post[written_on(3i)]\" value=\"1\" />\n"

    expected <<  %{<select id="post_written_on_2i" disabled="disabled" name="post[written_on(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_written_on_1i" disabled="disabled" name="post[written_on(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", { order: [ :month, :year ], use_separators: true }, disabled: true)
  end

  def test_date_select_within_fields_for
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    output_buffer = fields_for :post, @post do |f|
      concat f.date_select(:written_on, use_separators: true)
    end

    expected = "<select id='post_written_on_1i' name='post[written_on(1i)]'>\n<option value='1999'>1999</option>\n<option value='2000'>2000</option>\n<option value='2001'>2001</option>\n<option value='2002'>2002</option>\n<option value='2003'>2003</option>\n<option selected='selected' value='2004'>2004</option>\n<option value='2005'>2005</option>\n<option value='2006'>2006</option>\n<option value='2007'>2007</option>\n<option value='2008'>2008</option>\n<option value='2009'>2009</option>\n</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << "<select id='post_written_on_2i' name='post[written_on(2i)]'>\n<option value='1'>January</option>\n<option value='2'>February</option>\n<option value='3'>March</option>\n<option value='4'>April</option>\n<option value='5'>May</option>\n<option selected='selected' value='6'>June</option>\n<option value='7'>July</option>\n<option value='8'>August</option>\n<option value='9'>September</option>\n<option value='10'>October</option>\n<option value='11'>November</option>\n<option value='12'>December</option>\n</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << "<select id='post_written_on_3i' name='post[written_on(3i)]'>\n<option value='1'>1</option>\n<option value='2'>2</option>\n<option value='3'>3</option>\n<option value='4'>4</option>\n<option value='5'>5</option>\n<option value='6'>6</option>\n<option value='7'>7</option>\n<option value='8'>8</option>\n<option value='9'>9</option>\n<option value='10'>10</option>\n<option value='11'>11</option>\n<option value='12'>12</option>\n<option value='13'>13</option>\n<option value='14'>14</option>\n<option selected='selected' value='15'>15</option>\n<option value='16'>16</option>\n<option value='17'>17</option>\n<option value='18'>18</option>\n<option value='19'>19</option>\n<option value='20'>20</option>\n<option value='21'>21</option>\n<option value='22'>22</option>\n<option value='23'>23</option>\n<option value='24'>24</option>\n<option value='25'>25</option>\n<option value='26'>26</option>\n<option value='27'>27</option>\n<option value='28'>28</option>\n<option value='29'>29</option>\n<option value='30'>30</option>\n<option value='31'>31</option>\n</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal(expected, output_buffer)
  end

  def test_date_select_within_fields_for_with_index
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)
    id = 27

    output_buffer = fields_for :post, @post, index: id do |f|
      concat f.date_select(:written_on, use_separators: true)
    end

    expected = "<select id='post_#{id}_written_on_1i' name='post[#{id}][written_on(1i)]'>\n<option value='1999'>1999</option>\n<option value='2000'>2000</option>\n<option value='2001'>2001</option>\n<option value='2002'>2002</option>\n<option value='2003'>2003</option>\n<option selected='selected' value='2004'>2004</option>\n<option value='2005'>2005</option>\n<option value='2006'>2006</option>\n<option value='2007'>2007</option>\n<option value='2008'>2008</option>\n<option value='2009'>2009</option>\n</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << "<select id='post_#{id}_written_on_2i' name='post[#{id}][written_on(2i)]'>\n<option value='1'>January</option>\n<option value='2'>February</option>\n<option value='3'>March</option>\n<option value='4'>April</option>\n<option value='5'>May</option>\n<option selected='selected' value='6'>June</option>\n<option value='7'>July</option>\n<option value='8'>August</option>\n<option value='9'>September</option>\n<option value='10'>October</option>\n<option value='11'>November</option>\n<option value='12'>December</option>\n</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << "<select id='post_#{id}_written_on_3i' name='post[#{id}][written_on(3i)]'>\n<option value='1'>1</option>\n<option value='2'>2</option>\n<option value='3'>3</option>\n<option value='4'>4</option>\n<option value='5'>5</option>\n<option value='6'>6</option>\n<option value='7'>7</option>\n<option value='8'>8</option>\n<option value='9'>9</option>\n<option value='10'>10</option>\n<option value='11'>11</option>\n<option value='12'>12</option>\n<option value='13'>13</option>\n<option value='14'>14</option>\n<option selected='selected' value='15'>15</option>\n<option value='16'>16</option>\n<option value='17'>17</option>\n<option value='18'>18</option>\n<option value='19'>19</option>\n<option value='20'>20</option>\n<option value='21'>21</option>\n<option value='22'>22</option>\n<option value='23'>23</option>\n<option value='24'>24</option>\n<option value='25'>25</option>\n<option value='26'>26</option>\n<option value='27'>27</option>\n<option value='28'>28</option>\n<option value='29'>29</option>\n<option value='30'>30</option>\n<option value='31'>31</option>\n</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal(expected, output_buffer)
  end

  def test_date_select_within_fields_for_with_blank_index
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)
    id = nil

    output_buffer = fields_for :post, @post, index: id do |f|
      concat f.date_select(:written_on, use_separators: true)
    end

    expected = "<select id='post_#{id}_written_on_1i' name='post[#{id}][written_on(1i)]'>\n<option value='1999'>1999</option>\n<option value='2000'>2000</option>\n<option value='2001'>2001</option>\n<option value='2002'>2002</option>\n<option value='2003'>2003</option>\n<option selected='selected' value='2004'>2004</option>\n<option value='2005'>2005</option>\n<option value='2006'>2006</option>\n<option value='2007'>2007</option>\n<option value='2008'>2008</option>\n<option value='2009'>2009</option>\n</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << "<select id='post_#{id}_written_on_2i' name='post[#{id}][written_on(2i)]'>\n<option value='1'>January</option>\n<option value='2'>February</option>\n<option value='3'>March</option>\n<option value='4'>April</option>\n<option value='5'>May</option>\n<option selected='selected' value='6'>June</option>\n<option value='7'>July</option>\n<option value='8'>August</option>\n<option value='9'>September</option>\n<option value='10'>October</option>\n<option value='11'>November</option>\n<option value='12'>December</option>\n</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << "<select id='post_#{id}_written_on_3i' name='post[#{id}][written_on(3i)]'>\n<option value='1'>1</option>\n<option value='2'>2</option>\n<option value='3'>3</option>\n<option value='4'>4</option>\n<option value='5'>5</option>\n<option value='6'>6</option>\n<option value='7'>7</option>\n<option value='8'>8</option>\n<option value='9'>9</option>\n<option value='10'>10</option>\n<option value='11'>11</option>\n<option value='12'>12</option>\n<option value='13'>13</option>\n<option value='14'>14</option>\n<option selected='selected' value='15'>15</option>\n<option value='16'>16</option>\n<option value='17'>17</option>\n<option value='18'>18</option>\n<option value='19'>19</option>\n<option value='20'>20</option>\n<option value='21'>21</option>\n<option value='22'>22</option>\n<option value='23'>23</option>\n<option value='24'>24</option>\n<option value='25'>25</option>\n<option value='26'>26</option>\n<option value='27'>27</option>\n<option value='28'>28</option>\n<option value='29'>29</option>\n<option value='30'>30</option>\n<option value='31'>31</option>\n</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal(expected, output_buffer)
  end

  def test_date_select_with_index
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)
    id = 456

    expected = %{<select id="post_456_written_on_1i" name="post[#{id}][written_on(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_456_written_on_2i" name="post[#{id}][written_on(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_456_written_on_3i" name="post[#{id}][written_on(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", index: id, use_separators: true)
  end

  def test_date_select_with_auto_index
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)
    id = 123

    expected = %{<select id="post_123_written_on_1i" name="post[#{id}][written_on(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_123_written_on_2i" name="post[#{id}][written_on(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_123_written_on_3i" name="post[#{id}][written_on(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, date_select("post[]", "written_on", use_separators: true)
  end

  def test_date_select_with_different_order
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected =  %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    1.upto(31) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 15}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    1.upto(12) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 6}>#{Date::MONTHNAMES[i]}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected <<  %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    1999.upto(2009) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 2004}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", order: [:day, :month, :year], use_separators: true)
  end

  def test_date_select_with_nil
    @post = Post.new

    start_year = Time.now.year-5
    end_year   = Time.now.year+5
    expected =   %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    start_year.upto(end_year) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == Time.now.year}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    1.upto(12) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == Time.now.month}>#{Date::MONTHNAMES[i]}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    1.upto(31) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == Time.now.day}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", use_separators: true)
  end

  def test_date_select_with_nil_and_blank
    @post = Post.new

    start_year = Time.now.year-5
    end_year   = Time.now.year+5
    expected =   %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << "<option value=\"\"></option>\n"
    start_year.upto(end_year) { |i| expected << %(<option value="#{i}">#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << "<option value=\"\"></option>\n"
    1.upto(12) { |i| expected << %(<option value="#{i}">#{Date::MONTHNAMES[i]}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << "<option value=\"\"></option>\n"
    1.upto(31) { |i| expected << %(<option value="#{i}">#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", include_blank: true, use_separators: true)
  end

  def test_date_select_with_nil_and_blank_and_order
    @post = Post.new

    start_year = Time.now.year-5
    end_year   = Time.now.year+5

    expected = '<input name="post[written_on(3i)]" type="hidden" id="post_written_on_3i" value="1"/>' + "\n"
    expected <<   %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << "<option value=\"\"></option>\n"
    start_year.upto(end_year) { |i| expected << %(<option value="#{i}">#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << "<option value=\"\"></option>\n"
    1.upto(12) { |i| expected << %(<option value="#{i}">#{Date::MONTHNAMES[i]}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", order: [:year, :month], include_blank: true, use_separators: true)
  end

  def test_date_select_with_nil_and_blank_and_discard_month
    @post = Post.new

    start_year = Time.now.year-5
    end_year   = Time.now.year+5

    expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << "<option value=\"\"></option>\n"
    start_year.upto(end_year) { |i| expected << %(<option value="#{i}">#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << '<input name="post[written_on(2i)]" type="hidden" id="post_written_on_2i" value="1"/>' + "\n"
    expected << '<input name="post[written_on(3i)]" type="hidden" id="post_written_on_3i" value="1"/>' + "\n"

    assert_dom_equal expected, date_select("post", "written_on", discard_month: true, include_blank: true, use_separators: true)
  end

  def test_date_select_with_nil_and_blank_and_discard_year
    @post = Post.new

    expected = '<input id="post_written_on_1i" name="post[written_on(1i)]" type="hidden" value="1" />' + "\n"

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << "<option value=\"\"></option>\n"
    1.upto(12) { |i| expected << %(<option value="#{i}">#{Date::MONTHNAMES[i]}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << "<option value=\"\"></option>\n"
    1.upto(31) { |i| expected << %(<option value="#{i}">#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", discard_year: true, include_blank: true, use_separators: true)
  end

  def test_date_select_cant_override_discard_hour
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", discard_hour: false, use_separators: true)
  end

  def test_date_select_with_html_options
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]" class="selector">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]" class="selector">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]" class="selector">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", { use_separators: true }, class: 'selector')
  end

  def test_date_select_with_html_options_within_fields_for
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    output_buffer = fields_for :post, @post do |f|
      concat f.date_select(:written_on, { use_separators: true }, class: 'selector')
    end

    expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]" class="selector">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]" class="selector">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]" class="selector">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, output_buffer
  end

  def test_date_select_with_separator
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << " / "

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << " / "

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", { date_separator: " / ", use_separators: true })
  end

  def test_date_select_with_separator_and_order
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " / "

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << " / "

    expected << %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", { order: [:day, :month, :year], date_separator: " / ", use_separators: true })
  end

  def test_date_select_with_separator_and_order_and_year_discarded
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " / "

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %{<input type="hidden" id="post_written_on_1i" name="post[written_on(1i)]" value="2004" />\n}

    assert_dom_equal expected, date_select("post", "written_on", { order: [:day, :month, :year], discard_year: true, date_separator: " / ", use_separators: true })
  end

  def test_date_select_with_default_prompt
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="">Year</option>\n<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="">Month</option>\n<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << %{<option value="">Day</option>\n<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", prompt: true, use_separators: true)
  end

  def test_date_select_with_custom_prompt
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="">Choose year</option>\n<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="">Choose month</option>\n<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << %{<option value="">Choose day</option>\n<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", prompt: {year: 'Choose year', month: 'Choose month', day: 'Choose day'}, use_separators: true)
  end

  def test_date_select_with_inline_custom_separator
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="1999">1999yy</option>\n<option value="2000">2000yy</option>\n<option value="2001">2001yy</option>\n<option value="2002">2002yy</option>\n<option value="2003">2003yy</option>\n<option value="2004" selected="selected">2004yy</option>\n<option value="2005">2005yy</option>\n<option value="2006">2006yy</option>\n<option value="2007">2007yy</option>\n<option value="2008">2008yy</option>\n<option value="2009">2009yy</option>\n}
    expected << "</select>\n"

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << %{<option value="1">1dd</option>\n<option value="2">2dd</option>\n<option value="3">3dd</option>\n<option value="4">4dd</option>\n<option value="5">5dd</option>\n<option value="6">6dd</option>\n<option value="7">7dd</option>\n<option value="8">8dd</option>\n<option value="9">9dd</option>\n<option value="10">10dd</option>\n<option value="11">11dd</option>\n<option value="12">12dd</option>\n<option value="13">13dd</option>\n<option value="14">14dd</option>\n<option value="15" selected="selected">15dd</option>\n<option value="16">16dd</option>\n<option value="17">17dd</option>\n<option value="18">18dd</option>\n<option value="19">19dd</option>\n<option value="20">20dd</option>\n<option value="21">21dd</option>\n<option value="22">22dd</option>\n<option value="23">23dd</option>\n<option value="24">24dd</option>\n<option value="25">25dd</option>\n<option value="26">26dd</option>\n<option value="27">27dd</option>\n<option value="28">28dd</option>\n<option value="29">29dd</option>\n<option value="30">30dd</option>\n<option value="31">31dd</option>\n}
    expected << "</select>\n"

    assert_dom_equal expected, date_select("post", "written_on", use_separators: { inline: true })
  end

  def test_date_select_with_custom_separator_and_html_tag
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<div class="separator_year">yy</div>\n)

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<div class="separator_month">mm</div>\n)

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<div class="separator_day">dd</div>\n)

    assert_dom_equal expected, date_select("post", "written_on", use_separators: { html_tag: :div })
  end

  def test_date_select_with_custom_separator_and_class_prefix
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="foo_year">yy</span>\n)

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="foo_month">mm</span>\n)

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="foo_day">dd</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", use_separators: { class_prefix: 'foo_' })
  end

  def test_date_select_with_custom_separator_and_translation
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">foo</span>\n)

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">bar</span>\n)

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">baz</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", use_separators: { year: 'foo', month: 'bar', day: 'baz'})
  end

  def test_date_select_with_custom_separator_and_locale
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">年</span>\n)

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6" selected="selected">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">月</span>\n)

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">日</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", use_month_numbers: true, use_separators: true, locale: :ja)
  end

  def test_date_select_with_inline_custom_separator_and_locale
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="1999">1999年</option>\n<option value="2000">2000年</option>\n<option value="2001">2001年</option>\n<option value="2002">2002年</option>\n<option value="2003">2003年</option>\n<option value="2004" selected="selected">2004年</option>\n<option value="2005">2005年</option>\n<option value="2006">2006年</option>\n<option value="2007">2007年</option>\n<option value="2008">2008年</option>\n<option value="2009">2009年</option>\n}
    expected << "</select>\n"

    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="1">1月</option>\n<option value="2">2月</option>\n<option value="3">3月</option>\n<option value="4">4月</option>\n<option value="5">5月</option>\n<option value="6" selected="selected">6月</option>\n<option value="7">7月</option>\n<option value="8">8月</option>\n<option value="9">9月</option>\n<option value="10">10月</option>\n<option value="11">11月</option>\n<option value="12">12月</option>\n}
    expected << "</select>\n"

    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << %{<option value="1">1日</option>\n<option value="2">2日</option>\n<option value="3">3日</option>\n<option value="4">4日</option>\n<option value="5">5日</option>\n<option value="6">6日</option>\n<option value="7">7日</option>\n<option value="8">8日</option>\n<option value="9">9日</option>\n<option value="10">10日</option>\n<option value="11">11日</option>\n<option value="12">12日</option>\n<option value="13">13日</option>\n<option value="14">14日</option>\n<option value="15" selected="selected">15日</option>\n<option value="16">16日</option>\n<option value="17">17日</option>\n<option value="18">18日</option>\n<option value="19">19日</option>\n<option value="20">20日</option>\n<option value="21">21日</option>\n<option value="22">22日</option>\n<option value="23">23日</option>\n<option value="24">24日</option>\n<option value="25">25日</option>\n<option value="26">26日</option>\n<option value="27">27日</option>\n<option value="28">28日</option>\n<option value="29">29日</option>\n<option value="30">30日</option>\n<option value="31">31日</option>\n}
    expected << "</select>\n"

    assert_dom_equal expected, date_select("post", "written_on", use_separators: { inline: true }, locale: :ja)
  end

  def test_date_select_with_custom_separator_and_wrapper_select_tag
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = %(<div class="wrapper_select_year">\n)
    expected << %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << %(</div>\n)

    expected << %(<div class="wrapper_select_month">\n)
    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %(</div>\n)

    expected << %(<div class="wrapper_select_day">\n)
    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)
    expected << %(</div>\n)

    assert_dom_equal expected, date_select("post", "written_on", use_separators: { wrapper_select_tag: true })
  end

  def test_date_select_with_custom_separator_and_wrapper_select_tag_with_options
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    expected = %(<span class="foo_year">\n)
    expected << %{<select id="post_written_on_1i" name="post[written_on(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << %(</span>\n)

    expected << %(<span class="foo_month">\n)
    expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %(</span>\n)

    expected << %(<span class="foo_day">\n)
    expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)
    expected << %(</span>\n)

    assert_dom_equal expected, date_select("post", "written_on", use_separators: { wrapper_select_tag: { html_tag: :span, class_prefix: 'foo_' }})
  end

  def test_time_select
    @post = Post.new
    @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_written_on_1i" name="post[written_on(1i)]" value="2004" />\n}
    expected << %{<input type="hidden" id="post_written_on_2i" name="post[written_on(2i)]" value="6" />\n}
    expected << %{<input type="hidden" id="post_written_on_3i" name="post[written_on(3i)]" value="15" />\n}

    expected << %(<select id="post_written_on_4i" name="post[written_on(4i)]">\n)
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %(<select id="post_written_on_5i" name="post[written_on(5i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, time_select("post", "written_on", use_separators: true)
  end

  def test_time_select_with_selected
    @post = Post.new
    @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_written_on_1i" name="post[written_on(1i)]" value="2004" />\n}
    expected << %{<input type="hidden" id="post_written_on_2i" name="post[written_on(2i)]" value="6" />\n}
    expected << %{<input type="hidden" id="post_written_on_3i" name="post[written_on(3i)]" value="15" />\n}

    expected << %(<select id="post_written_on_4i" name="post[written_on(4i)]">\n)
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 12}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %(<select id="post_written_on_5i" name="post[written_on(5i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 20}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, time_select("post", "written_on", selected: Time.local(2004, 6, 15, 12, 20, 30), use_separators: true)
  end

  def test_time_select_with_selected_nil
    @post = Post.new
    @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_written_on_1i" name="post[written_on(1i)]" value="1" />\n}
    expected << %{<input type="hidden" id="post_written_on_2i" name="post[written_on(2i)]" value="1" />\n}
    expected << %{<input type="hidden" id="post_written_on_3i" name="post[written_on(3i)]" value="1" />\n}

    expected << %(<select id="post_written_on_4i" name="post[written_on(4i)]">\n)
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}">#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %(<select id="post_written_on_5i" name="post[written_on(5i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}">#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, time_select("post", "written_on", discard_year: true, discard_month: true, discard_day: true, selected: nil, use_separators: true)
  end

  def test_time_select_without_date_hidden_fields
    @post = Post.new
    @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %(<select id="post_written_on_4i" name="post[written_on(4i)]">\n)
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %(<select id="post_written_on_5i" name="post[written_on(5i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, time_select("post", "written_on", ignore_date: true, use_separators: true)
  end

  def test_time_select_with_seconds
    @post = Post.new
    @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_written_on_1i" name="post[written_on(1i)]" value="2004" />\n}
    expected << %{<input type="hidden" id="post_written_on_2i" name="post[written_on(2i)]" value="6" />\n}
    expected << %{<input type="hidden" id="post_written_on_3i" name="post[written_on(3i)]" value="15" />\n}

    expected << %(<select id="post_written_on_4i" name="post[written_on(4i)]">\n)
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %(<select id="post_written_on_5i" name="post[written_on(5i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)
    expected << " : "
    expected << %(<select id="post_written_on_6i" name="post[written_on(6i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 35}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_second">sec</span>\n)

    assert_dom_equal expected, time_select("post", "written_on", include_seconds: true, use_separators: true)
  end

  def test_time_select_with_html_options
    @post = Post.new
    @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_written_on_1i" name="post[written_on(1i)]" value="2004" />\n}
    expected << %{<input type="hidden" id="post_written_on_2i" name="post[written_on(2i)]" value="6" />\n}
    expected << %{<input type="hidden" id="post_written_on_3i" name="post[written_on(3i)]" value="15" />\n}

    expected << %(<select id="post_written_on_4i" name="post[written_on(4i)]" class="selector">\n)
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %(<select id="post_written_on_5i" name="post[written_on(5i)]" class="selector">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, time_select("post", "written_on", { use_separators: true }, class: 'selector')
  end

  def test_time_select_with_html_options_within_fields_for
    @post = Post.new
    @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

    output_buffer = fields_for :post, @post do |f|
      concat f.time_select(:written_on, { use_separators: true }, class: 'selector')
    end

    expected = %{<input type="hidden" id="post_written_on_1i" name="post[written_on(1i)]" value="2004" />\n}
    expected << %{<input type="hidden" id="post_written_on_2i" name="post[written_on(2i)]" value="6" />\n}
    expected << %{<input type="hidden" id="post_written_on_3i" name="post[written_on(3i)]" value="15" />\n}

    expected << %(<select id="post_written_on_4i" name="post[written_on(4i)]" class="selector">\n)
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %(<select id="post_written_on_5i" name="post[written_on(5i)]" class="selector">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, output_buffer
  end

  def test_time_select_with_separator
    @post = Post.new
    @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_written_on_1i" name="post[written_on(1i)]" value="2004" />\n}
    expected << %{<input type="hidden" id="post_written_on_2i" name="post[written_on(2i)]" value="6" />\n}
    expected << %{<input type="hidden" id="post_written_on_3i" name="post[written_on(3i)]" value="15" />\n}

    expected << %(<select id="post_written_on_4i" name="post[written_on(4i)]">\n)
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " - "

    expected << %(<select id="post_written_on_5i" name="post[written_on(5i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    expected << " - "

    expected << %(<select id="post_written_on_6i" name="post[written_on(6i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 35}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_second">sec</span>\n)

    assert_dom_equal expected, time_select("post", "written_on", { time_separator: " - ", include_seconds: true, use_separators: true })
  end

  def test_time_select_with_default_prompt
    @post = Post.new
    @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_written_on_1i" name="post[written_on(1i)]" value="2004" />\n}
    expected << %{<input type="hidden" id="post_written_on_2i" name="post[written_on(2i)]" value="6" />\n}
    expected << %{<input type="hidden" id="post_written_on_3i" name="post[written_on(3i)]" value="15" />\n}

    expected << %(<select id="post_written_on_4i" name="post[written_on(4i)]">\n)
    expected << %(<option value="">Hour</option>\n)
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %(<select id="post_written_on_5i" name="post[written_on(5i)]">\n)
    expected << %(<option value="">Minute</option>\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, time_select("post", "written_on", prompt: true, use_separators: true)
  end

  def test_time_select_with_custom_prompt
    @post = Post.new
    @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_written_on_1i" name="post[written_on(1i)]" value="2004" />\n}
    expected << %{<input type="hidden" id="post_written_on_2i" name="post[written_on(2i)]" value="6" />\n}
    expected << %{<input type="hidden" id="post_written_on_3i" name="post[written_on(3i)]" value="15" />\n}

    expected << %(<select id="post_written_on_4i" name="post[written_on(4i)]">\n)
    expected << %(<option value="">Choose hour</option>\n)
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %(<select id="post_written_on_5i" name="post[written_on(5i)]">\n)
    expected << %(<option value="">Choose minute</option>\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, time_select("post", "written_on", prompt: {hour: 'Choose hour', minute: 'Choose minute'}, use_separators: true)
  end

  def test_time_select_with_disabled_html_option
    @post = Post.new
    @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_written_on_1i" disabled="disabled" name="post[written_on(1i)]" value="2004" />\n}
    expected << %{<input type="hidden" id="post_written_on_2i" disabled="disabled" name="post[written_on(2i)]" value="6" />\n}
    expected << %{<input type="hidden" id="post_written_on_3i" disabled="disabled" name="post[written_on(3i)]" value="15" />\n}

    expected << %(<select id="post_written_on_4i" disabled="disabled" name="post[written_on(4i)]">\n)
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %(<select id="post_written_on_5i" disabled="disabled" name="post[written_on(5i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, time_select("post", "written_on", { use_separators: true }, disabled: true)
  end

  def test_time_select_with_inline_custom_separator
    @post = Post.new
    @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_written_on_1i" name="post[written_on(1i)]" value="2004" />\n}
    expected << %{<input type="hidden" id="post_written_on_2i" name="post[written_on(2i)]" value="6" />\n}
    expected << %{<input type="hidden" id="post_written_on_3i" name="post[written_on(3i)]" value="15" />\n}

    expected << %(<select id="post_written_on_4i" name="post[written_on(4i)]">\n)
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}h</option>\n) }
    expected << "</select>\n"
    expected << " : "
    expected << %(<select id="post_written_on_5i" name="post[written_on(5i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}min</option>\n) }
    expected << "</select>\n"

    assert_dom_equal expected, time_select("post", "written_on", use_separators: { inline: true })
  end

  def test_time_select_with_custom_separator_and_html_tag
    @post = Post.new
    @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_written_on_1i" name="post[written_on(1i)]" value="2004" />\n}
    expected << %{<input type="hidden" id="post_written_on_2i" name="post[written_on(2i)]" value="6" />\n}
    expected << %{<input type="hidden" id="post_written_on_3i" name="post[written_on(3i)]" value="15" />\n}

    expected << %(<select id="post_written_on_4i" name="post[written_on(4i)]">\n)
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<div class="separator_hour">h</div>\n)
    expected << " : "
    expected << %(<select id="post_written_on_5i" name="post[written_on(5i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<div class="separator_minute">min</div>\n)

    assert_dom_equal expected, time_select("post", "written_on", use_separators: { html_tag: :div })
  end

  def test_time_select_with_custom_separator_and_class_prefix
    @post = Post.new
    @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_written_on_1i" name="post[written_on(1i)]" value="2004" />\n}
    expected << %{<input type="hidden" id="post_written_on_2i" name="post[written_on(2i)]" value="6" />\n}
    expected << %{<input type="hidden" id="post_written_on_3i" name="post[written_on(3i)]" value="15" />\n}

    expected << %(<select id="post_written_on_4i" name="post[written_on(4i)]">\n)
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="foo_hour">h</span>\n)
    expected << " : "
    expected << %(<select id="post_written_on_5i" name="post[written_on(5i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="foo_minute">min</span>\n)

    assert_dom_equal expected, time_select("post", "written_on", use_separators: { class_prefix: 'foo_' })
  end

  def test_time_select_with_custom_separator_and_translation
    @post = Post.new
    @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_written_on_1i" name="post[written_on(1i)]" value="2004" />\n}
    expected << %{<input type="hidden" id="post_written_on_2i" name="post[written_on(2i)]" value="6" />\n}
    expected << %{<input type="hidden" id="post_written_on_3i" name="post[written_on(3i)]" value="15" />\n}

    expected << %(<select id="post_written_on_4i" name="post[written_on(4i)]">\n)
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">foo</span>\n)
    expected << " : "
    expected << %(<select id="post_written_on_5i" name="post[written_on(5i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">bar</span>\n)

    assert_dom_equal expected, time_select("post", "written_on", use_separators: { hour: 'foo', minute: 'bar' })
  end

  def test_time_select_with_custom_separator_and_wrapper_select_tag
    @post = Post.new
    @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_written_on_1i" name="post[written_on(1i)]" value="2004" />\n}
    expected << %{<input type="hidden" id="post_written_on_2i" name="post[written_on(2i)]" value="6" />\n}
    expected << %{<input type="hidden" id="post_written_on_3i" name="post[written_on(3i)]" value="15" />\n}

    expected << %(<div class="wrapper_select_hour">\n)
    expected << %(<select id="post_written_on_4i" name="post[written_on(4i)]">\n)
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << %(</div>\n)
    expected << " : "
    expected << %(<div class="wrapper_select_minute">\n)
    expected << %(<select id="post_written_on_5i" name="post[written_on(5i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)
    expected << %(</div>\n)

    assert_dom_equal expected, time_select("post", "written_on", use_separators: { wrapper_select_tag: true })
  end

  def test_datetime_select
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 16, 35)

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35" selected="selected">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", use_separators: true)
  end

  def test_datetime_select_with_selected
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 16, 35)

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3" selected="selected">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10" selected="selected">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12" selected="selected">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30" selected="selected">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", selected: Time.local(2004, 3, 10, 12, 30), use_separators: true)
  end

  def test_datetime_select_with_selected_nil
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 16, 35)

    expected = '<input id="post_updated_at_1i" name="post[updated_at(1i)]" type="hidden" value="1"/>' + "\n"

    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", discard_year: true, selected: nil, use_separators: true)
  end

  def test_datetime_select_defaults_to_time_zone_now_when_config_time_zone_is_set
    # The love zone is UTC+0
    mytz = Class.new(ActiveSupport::TimeZone) {
      attr_accessor :now
    }.create('tenderlove', 0, ActiveSupport::TimeZone.find_tzinfo('UTC'))

    now       = Time.mktime(2004, 6, 15, 16, 35, 0)
    mytz.now  = now
    Time.zone = mytz

    assert_equal mytz, Time.zone

    @post = Post.new

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35" selected="selected">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", use_separators: true)
  ensure
    Time.zone = nil
  end

  def test_datetime_select_with_html_options_within_fields_for
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 16, 35)

    output_buffer = fields_for :post, @post do |f|
      concat f.datetime_select(:updated_at, { use_separators: true }, class: 'selector')
    end

    expected = "<select id='post_updated_at_1i' name='post[updated_at(1i)]' class='selector'>\n<option value='1999'>1999</option>\n<option value='2000'>2000</option>\n<option value='2001'>2001</option>\n<option value='2002'>2002</option>\n<option value='2003'>2003</option>\n<option selected='selected' value='2004'>2004</option>\n<option value='2005'>2005</option>\n<option value='2006'>2006</option>\n<option value='2007'>2007</option>\n<option value='2008'>2008</option>\n<option value='2009'>2009</option>\n</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << "<select id='post_updated_at_2i' name='post[updated_at(2i)]' class='selector'>\n<option value='1'>January</option>\n<option value='2'>February</option>\n<option value='3'>March</option>\n<option value='4'>April</option>\n<option value='5'>May</option>\n<option selected='selected' value='6'>June</option>\n<option value='7'>July</option>\n<option value='8'>August</option>\n<option value='9'>September</option>\n<option value='10'>October</option>\n<option value='11'>November</option>\n<option value='12'>December</option>\n</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << "<select id='post_updated_at_3i' name='post[updated_at(3i)]' class='selector'>\n<option value='1'>1</option>\n<option value='2'>2</option>\n<option value='3'>3</option>\n<option value='4'>4</option>\n<option value='5'>5</option>\n<option value='6'>6</option>\n<option value='7'>7</option>\n<option value='8'>8</option>\n<option value='9'>9</option>\n<option value='10'>10</option>\n<option value='11'>11</option>\n<option value='12'>12</option>\n<option value='13'>13</option>\n<option value='14'>14</option>\n<option selected='selected' value='15'>15</option>\n<option value='16'>16</option>\n<option value='17'>17</option>\n<option value='18'>18</option>\n<option value='19'>19</option>\n<option value='20'>20</option>\n<option value='21'>21</option>\n<option value='22'>22</option>\n<option value='23'>23</option>\n<option value='24'>24</option>\n<option value='25'>25</option>\n<option value='26'>26</option>\n<option value='27'>27</option>\n<option value='28'>28</option>\n<option value='29'>29</option>\n<option value='30'>30</option>\n<option value='31'>31</option>\n</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)
    expected << " &mdash; <select id='post_updated_at_4i' name='post[updated_at(4i)]' class='selector'>\n<option value='00'>00</option>\n<option value='01'>01</option>\n<option value='02'>02</option>\n<option value='03'>03</option>\n<option value='04'>04</option>\n<option value='05'>05</option>\n<option value='06'>06</option>\n<option value='07'>07</option>\n<option value='08'>08</option>\n<option value='09'>09</option>\n<option value='10'>10</option>\n<option value='11'>11</option>\n<option value='12'>12</option>\n<option value='13'>13</option>\n<option value='14'>14</option>\n<option value='15'>15</option>\n<option selected='selected' value='16'>16</option>\n<option value='17'>17</option>\n<option value='18'>18</option>\n<option value='19'>19</option>\n<option value='20'>20</option>\n<option value='21'>21</option>\n<option value='22'>22</option>\n<option value='23'>23</option>\n</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : <select id='post_updated_at_5i' name='post[updated_at(5i)]' class='selector'>\n<option value='00'>00</option>\n<option value='01'>01</option>\n<option value='02'>02</option>\n<option value='03'>03</option>\n<option value='04'>04</option>\n<option value='05'>05</option>\n<option value='06'>06</option>\n<option value='07'>07</option>\n<option value='08'>08</option>\n<option value='09'>09</option>\n<option value='10'>10</option>\n<option value='11'>11</option>\n<option value='12'>12</option>\n<option value='13'>13</option>\n<option value='14'>14</option>\n<option value='15'>15</option>\n<option value='16'>16</option>\n<option value='17'>17</option>\n<option value='18'>18</option>\n<option value='19'>19</option>\n<option value='20'>20</option>\n<option value='21'>21</option>\n<option value='22'>22</option>\n<option value='23'>23</option>\n<option value='24'>24</option>\n<option value='25'>25</option>\n<option value='26'>26</option>\n<option value='27'>27</option>\n<option value='28'>28</option>\n<option value='29'>29</option>\n<option value='30'>30</option>\n<option value='31'>31</option>\n<option value='32'>32</option>\n<option value='33'>33</option>\n<option value='34'>34</option>\n<option selected='selected' value='35'>35</option>\n<option value='36'>36</option>\n<option value='37'>37</option>\n<option value='38'>38</option>\n<option value='39'>39</option>\n<option value='40'>40</option>\n<option value='41'>41</option>\n<option value='42'>42</option>\n<option value='43'>43</option>\n<option value='44'>44</option>\n<option value='45'>45</option>\n<option value='46'>46</option>\n<option value='47'>47</option>\n<option value='48'>48</option>\n<option value='49'>49</option>\n<option value='50'>50</option>\n<option value='51'>51</option>\n<option value='52'>52</option>\n<option value='53'>53</option>\n<option value='54'>54</option>\n<option value='55'>55</option>\n<option value='56'>56</option>\n<option value='57'>57</option>\n<option value='58'>58</option>\n<option value='59'>59</option>\n</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, output_buffer
  end

  def test_datetime_select_with_separators
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << " / "

    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << " / "

    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " , "

    expected << %(<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n)
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " - "

    expected << %(<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    expected << " - "

    expected << %(<select id="post_updated_at_6i" name="post[updated_at(6i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 35}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_second">sec</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", { date_separator: " / ", datetime_separator: " , ", time_separator: " - ", include_seconds: true, use_separators: true })
  end

  def test_datetime_select_with_integer
    @post = Post.new
    @post.updated_at = 3
    datetime_select("post", "updated_at", use_separators: true)
  end

  def test_datetime_select_with_infinity # Float
    @post = Post.new
    @post.updated_at = (-1.0/0)
    datetime_select("post", "updated_at", use_separators: true)
  end

  def test_datetime_select_with_default_prompt
    @post = Post.new
    @post.updated_at = nil

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    expected << %{<option value="">Year</option>\n<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    expected << %{<option value="">Month</option>\n<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    expected << %{<option value="">Day</option>\n<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    expected << %{<option value="">Hour</option>\n<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    expected << %{<option value="">Minute</option>\n<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", start_year: 1999, end_year: 2009,  prompt: true, use_separators: true)
  end

  def test_datetime_select_with_custom_prompt
    @post = Post.new
    @post.updated_at = nil

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    expected << %{<option value="">Choose year</option>\n<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    expected << %{<option value="">Choose month</option>\n<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    expected << %{<option value="">Choose day</option>\n<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    expected << %{<option value="">Choose hour</option>\n<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    expected << %{<option value="">Choose minute</option>\n<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", start_year: 1999, end_year: 2009, prompt: {year: 'Choose year', month: 'Choose month', day: 'Choose day', hour: 'Choose hour', minute: 'Choose minute'}, use_separators: true)
  end

  def test_datetime_select_with_inline_custom_separator
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 16, 35)

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    expected << %{<option value="1999">1999yy</option>\n<option value="2000">2000yy</option>\n<option value="2001">2001yy</option>\n<option value="2002">2002yy</option>\n<option value="2003">2003yy</option>\n<option value="2004" selected="selected">2004yy</option>\n<option value="2005">2005yy</option>\n<option value="2006">2006yy</option>\n<option value="2007">2007yy</option>\n<option value="2008">2008yy</option>\n<option value="2009">2009yy</option>\n}
    expected << "</select>\n"

    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"

    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    expected << %{<option value="1">1dd</option>\n<option value="2">2dd</option>\n<option value="3">3dd</option>\n<option value="4">4dd</option>\n<option value="5">5dd</option>\n<option value="6">6dd</option>\n<option value="7">7dd</option>\n<option value="8">8dd</option>\n<option value="9">9dd</option>\n<option value="10">10dd</option>\n<option value="11">11dd</option>\n<option value="12">12dd</option>\n<option value="13">13dd</option>\n<option value="14">14dd</option>\n<option value="15" selected="selected">15dd</option>\n<option value="16">16dd</option>\n<option value="17">17dd</option>\n<option value="18">18dd</option>\n<option value="19">19dd</option>\n<option value="20">20dd</option>\n<option value="21">21dd</option>\n<option value="22">22dd</option>\n<option value="23">23dd</option>\n<option value="24">24dd</option>\n<option value="25">25dd</option>\n<option value="26">26dd</option>\n<option value="27">27dd</option>\n<option value="28">28dd</option>\n<option value="29">29dd</option>\n<option value="30">30dd</option>\n<option value="31">31dd</option>\n}
    expected << "</select>\n"

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    expected << %{<option value="00">00h</option>\n<option value="01">01h</option>\n<option value="02">02h</option>\n<option value="03">03h</option>\n<option value="04">04h</option>\n<option value="05">05h</option>\n<option value="06">06h</option>\n<option value="07">07h</option>\n<option value="08">08h</option>\n<option value="09">09h</option>\n<option value="10">10h</option>\n<option value="11">11h</option>\n<option value="12">12h</option>\n<option value="13">13h</option>\n<option value="14">14h</option>\n<option value="15">15h</option>\n<option value="16" selected="selected">16h</option>\n<option value="17">17h</option>\n<option value="18">18h</option>\n<option value="19">19h</option>\n<option value="20">20h</option>\n<option value="21">21h</option>\n<option value="22">22h</option>\n<option value="23">23h</option>\n}
    expected << "</select>\n"
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    expected << %{<option value="00">00min</option>\n<option value="01">01min</option>\n<option value="02">02min</option>\n<option value="03">03min</option>\n<option value="04">04min</option>\n<option value="05">05min</option>\n<option value="06">06min</option>\n<option value="07">07min</option>\n<option value="08">08min</option>\n<option value="09">09min</option>\n<option value="10">10min</option>\n<option value="11">11min</option>\n<option value="12">12min</option>\n<option value="13">13min</option>\n<option value="14">14min</option>\n<option value="15">15min</option>\n<option value="16">16min</option>\n<option value="17">17min</option>\n<option value="18">18min</option>\n<option value="19">19min</option>\n<option value="20">20min</option>\n<option value="21">21min</option>\n<option value="22">22min</option>\n<option value="23">23min</option>\n<option value="24">24min</option>\n<option value="25">25min</option>\n<option value="26">26min</option>\n<option value="27">27min</option>\n<option value="28">28min</option>\n<option value="29">29min</option>\n<option value="30">30min</option>\n<option value="31">31min</option>\n<option value="32">32min</option>\n<option value="33">33min</option>\n<option value="34">34min</option>\n<option value="35" selected="selected">35min</option>\n<option value="36">36min</option>\n<option value="37">37min</option>\n<option value="38">38min</option>\n<option value="39">39min</option>\n<option value="40">40min</option>\n<option value="41">41min</option>\n<option value="42">42min</option>\n<option value="43">43min</option>\n<option value="44">44min</option>\n<option value="45">45min</option>\n<option value="46">46min</option>\n<option value="47">47min</option>\n<option value="48">48min</option>\n<option value="49">49min</option>\n<option value="50">50min</option>\n<option value="51">51min</option>\n<option value="52">52min</option>\n<option value="53">53min</option>\n<option value="54">54min</option>\n<option value="55">55min</option>\n<option value="56">56min</option>\n<option value="57">57min</option>\n<option value="58">58min</option>\n<option value="59">59min</option>\n}
    expected << "</select>\n"

    assert_dom_equal expected, datetime_select("post", "updated_at", use_separators: { inline: true })
  end

  def test_datetime_select_with_custom_separator_and_html_tag
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 16, 35)

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<div class="separator_year">yy</div>\n)

    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<div class="separator_month">mm</div>\n)

    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<div class="separator_day">dd</div>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
    expected << "</select>\n"
    expected << %(<div class="separator_hour">h</div>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35" selected="selected">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
    expected << "</select>\n"
    expected << %(<div class="separator_minute">min</div>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", use_separators: { html_tag: :div })
  end

  def test_datetime_select_with_custom_separator_and_class_prefix
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 16, 35)

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="foo_year">yy</span>\n)

    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="foo_month">mm</span>\n)

    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="foo_day">dd</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
    expected << "</select>\n"
    expected << %(<span class="foo_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35" selected="selected">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
    expected << "</select>\n"
    expected << %(<span class="foo_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", use_separators: { class_prefix: 'foo_' })
  end

  def test_datetime_select_with_custom_separator_and_translation
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 16, 35)

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">foo</span>\n)

    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">bar</span>\n)

    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">baz</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_hour">hoge</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35" selected="selected">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_minute">fuga</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", use_separators: { year: 'foo', month: 'bar', day: 'baz', hour: 'hoge', minute: 'fuga' })
  end

  def test_datetime_select_with_custom_separator_and_locale
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 16, 35)

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">年</span>\n)

    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6" selected="selected">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">月</span>\n)

    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">日</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_hour">時</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35" selected="selected">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_minute">分</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", use_month_numbers: true, use_separators: true, locale: :ja)
  end

  def test_datetime_select_with_inline_custom_separator_and_locale
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 16, 35)

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    expected << %{<option value="1999">1999年</option>\n<option value="2000">2000年</option>\n<option value="2001">2001年</option>\n<option value="2002">2002年</option>\n<option value="2003">2003年</option>\n<option value="2004" selected="selected">2004年</option>\n<option value="2005">2005年</option>\n<option value="2006">2006年</option>\n<option value="2007">2007年</option>\n<option value="2008">2008年</option>\n<option value="2009">2009年</option>\n}
    expected << "</select>\n"

    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    expected << %{<option value="1">1月</option>\n<option value="2">2月</option>\n<option value="3">3月</option>\n<option value="4">4月</option>\n<option value="5">5月</option>\n<option value="6" selected="selected">6月</option>\n<option value="7">7月</option>\n<option value="8">8月</option>\n<option value="9">9月</option>\n<option value="10">10月</option>\n<option value="11">11月</option>\n<option value="12">12月</option>\n}
    expected << "</select>\n"

    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    expected << %{<option value="1">1日</option>\n<option value="2">2日</option>\n<option value="3">3日</option>\n<option value="4">4日</option>\n<option value="5">5日</option>\n<option value="6">6日</option>\n<option value="7">7日</option>\n<option value="8">8日</option>\n<option value="9">9日</option>\n<option value="10">10日</option>\n<option value="11">11日</option>\n<option value="12">12日</option>\n<option value="13">13日</option>\n<option value="14">14日</option>\n<option value="15" selected="selected">15日</option>\n<option value="16">16日</option>\n<option value="17">17日</option>\n<option value="18">18日</option>\n<option value="19">19日</option>\n<option value="20">20日</option>\n<option value="21">21日</option>\n<option value="22">22日</option>\n<option value="23">23日</option>\n<option value="24">24日</option>\n<option value="25">25日</option>\n<option value="26">26日</option>\n<option value="27">27日</option>\n<option value="28">28日</option>\n<option value="29">29日</option>\n<option value="30">30日</option>\n<option value="31">31日</option>\n}
    expected << "</select>\n"

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    expected << %{<option value="00">00時</option>\n<option value="01">01時</option>\n<option value="02">02時</option>\n<option value="03">03時</option>\n<option value="04">04時</option>\n<option value="05">05時</option>\n<option value="06">06時</option>\n<option value="07">07時</option>\n<option value="08">08時</option>\n<option value="09">09時</option>\n<option value="10">10時</option>\n<option value="11">11時</option>\n<option value="12">12時</option>\n<option value="13">13時</option>\n<option value="14">14時</option>\n<option value="15">15時</option>\n<option value="16" selected="selected">16時</option>\n<option value="17">17時</option>\n<option value="18">18時</option>\n<option value="19">19時</option>\n<option value="20">20時</option>\n<option value="21">21時</option>\n<option value="22">22時</option>\n<option value="23">23時</option>\n}
    expected << "</select>\n"
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    expected << %{<option value="00">00分</option>\n<option value="01">01分</option>\n<option value="02">02分</option>\n<option value="03">03分</option>\n<option value="04">04分</option>\n<option value="05">05分</option>\n<option value="06">06分</option>\n<option value="07">07分</option>\n<option value="08">08分</option>\n<option value="09">09分</option>\n<option value="10">10分</option>\n<option value="11">11分</option>\n<option value="12">12分</option>\n<option value="13">13分</option>\n<option value="14">14分</option>\n<option value="15">15分</option>\n<option value="16">16分</option>\n<option value="17">17分</option>\n<option value="18">18分</option>\n<option value="19">19分</option>\n<option value="20">20分</option>\n<option value="21">21分</option>\n<option value="22">22分</option>\n<option value="23">23分</option>\n<option value="24">24分</option>\n<option value="25">25分</option>\n<option value="26">26分</option>\n<option value="27">27分</option>\n<option value="28">28分</option>\n<option value="29">29分</option>\n<option value="30">30分</option>\n<option value="31">31分</option>\n<option value="32">32分</option>\n<option value="33">33分</option>\n<option value="34">34分</option>\n<option value="35" selected="selected">35分</option>\n<option value="36">36分</option>\n<option value="37">37分</option>\n<option value="38">38分</option>\n<option value="39">39分</option>\n<option value="40">40分</option>\n<option value="41">41分</option>\n<option value="42">42分</option>\n<option value="43">43分</option>\n<option value="44">44分</option>\n<option value="45">45分</option>\n<option value="46">46分</option>\n<option value="47">47分</option>\n<option value="48">48分</option>\n<option value="49">49分</option>\n<option value="50">50分</option>\n<option value="51">51分</option>\n<option value="52">52分</option>\n<option value="53">53分</option>\n<option value="54">54分</option>\n<option value="55">55分</option>\n<option value="56">56分</option>\n<option value="57">57分</option>\n<option value="58">58分</option>\n<option value="59">59分</option>\n}
    expected << "</select>\n"

    assert_dom_equal expected, datetime_select("post", "updated_at", use_separators: { inline: true }, locale: :ja)
  end

  def test_datetime_select_with_custom_separator_and_wrapper_select_tag
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 16, 35)

    expected = %(<div class="wrapper_select_year">\n)
    expected << %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << %(</div>\n)

    expected << %(<div class="wrapper_select_month">\n)
    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %(</div>\n)

    expected << %(<div class="wrapper_select_day">\n)
    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)
    expected << %(</div>\n)

    expected << " &mdash; "

    expected << %(<div class="wrapper_select_hour">\n)
    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << %(</div>\n)
    expected << " : "
    expected << %(<div class="wrapper_select_minute">\n)
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35" selected="selected">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)
    expected << %(</div>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", use_separators: { wrapper_select_tag: true })
  end

  def test_datetime_select_with_custom_separator_and_wrapper_select_tag_with_options
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 16, 35)

    expected = %(<span class="foo_year">\n)
    expected << %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << %(</span>\n)

    expected << %(<span class="foo_month">\n)
    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %(</span>\n)

    expected << %(<span class="foo_day">\n)
    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)
    expected << %(</span>\n)

    expected << " &mdash; "

    expected << %(<span class="foo_hour">\n)
    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << %(</span>\n)
    expected << " : "
    expected << %(<span class="foo_minute">\n)
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35" selected="selected">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)
    expected << %(</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", use_separators: { wrapper_select_tag: { html_tag: :span, class_prefix: 'foo_' }})
  end

  def test_date_select_with_zero_value_and_no_start_year
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    (Date.today.year-5).upto(Date.today.year+1) { |y| expected << %(<option value="#{y}">#{y}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, select_date(0, end_year: Date.today.year+1, prefix: "date[first]", use_separators: true)
  end

  def test_date_select_with_zero_value_and_no_end_year
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    last_year = Time.now.year + 5
    2003.upto(last_year) { |y| expected << %(<option value="#{y}">#{y}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, select_date(0, start_year: 2003, prefix: "date[first]", use_separators: true)
  end

  def test_date_select_with_zero_value_and_no_start_and_end_year
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    (Date.today.year-5).upto(Date.today.year+5) { |y| expected << %(<option value="#{y}">#{y}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, select_date(0, prefix: "date[first]", use_separators: true)
  end

  def test_date_select_with_nil_value_and_no_start_and_end_year
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    (Date.today.year-5).upto(Date.today.year+5) { |y| expected << %(<option value="#{y}">#{y}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, select_date(nil, prefix: "date[first]", use_separators: true)
  end

  def test_datetime_select_with_nil_value_and_no_start_and_end_year
    expected =  %(<select id="date_first_year" name="date[first][year]">\n)
    (Date.today.year-5).upto(Date.today.year+5) { |y| expected << %(<option value="#{y}">#{y}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %(<select id="date_first_month" name="date[first][month]">\n)
    expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %(<select id="date_first_day" name="date[first][day]">\n)
    expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %(<select id="date_first_hour" name="date[first][hour]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)

    expected << " : "

    expected << %(<select id="date_first_minute" name="date[first][minute]">\n)
    expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, select_datetime(nil, prefix: "date[first]", use_separators: true)
  end

  def test_datetime_select_with_options_index
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 16, 35)
    id = 456

    expected = %{<select id="post_456_updated_at_1i" name="post[#{id}][updated_at(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_456_updated_at_2i" name="post[#{id}][updated_at(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_456_updated_at_3i" name="post[#{id}][updated_at(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_456_updated_at_4i" name="post[#{id}][updated_at(4i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_456_updated_at_5i" name="post[#{id}][updated_at(5i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35" selected="selected">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", index: id, use_separators: true)
  end

  def test_datetime_select_within_fields_for_with_options_index
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 16, 35)
    id = 456

    output_buffer = fields_for :post, @post, index: id do |f|
      concat f.datetime_select(:updated_at, use_separators: true)
    end

    expected = %{<select id="post_456_updated_at_1i" name="post[#{id}][updated_at(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_456_updated_at_2i" name="post[#{id}][updated_at(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_456_updated_at_3i" name="post[#{id}][updated_at(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_456_updated_at_4i" name="post[#{id}][updated_at(4i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_456_updated_at_5i" name="post[#{id}][updated_at(5i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35" selected="selected">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, output_buffer
  end

  def test_datetime_select_with_auto_index
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 16, 35)
    id = @post.id

    expected = %{<select id="post_123_updated_at_1i" name="post[#{id}][updated_at(1i)]">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_123_updated_at_2i" name="post[#{id}][updated_at(2i)]">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_123_updated_at_3i" name="post[#{id}][updated_at(3i)]">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_123_updated_at_4i" name="post[#{id}][updated_at(4i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_123_updated_at_5i" name="post[#{id}][updated_at(5i)]">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35" selected="selected">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post[]", "updated_at", use_separators: true)
  end

  def test_datetime_select_with_seconds
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    1999.upto(2009) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 2004}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    1.upto(12) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 6}>#{Date::MONTHNAMES[i]}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    1.upto(31) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 15}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_6i" name="post[updated_at(6i)]">\n}
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 35}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_second">sec</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", include_seconds: true, use_separators: true)
  end

  def test_datetime_select_discard_year
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_updated_at_1i" name="post[updated_at(1i)]" value="2004" />\n}
    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    1.upto(12) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 6}>#{Date::MONTHNAMES[i]}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    1.upto(31) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 15}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", discard_year: true, use_separators: true)
  end

  def test_datetime_select_discard_month
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    1999.upto(2009) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 2004}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
   expected << %{<input type="hidden" id="post_updated_at_2i" name="post[updated_at(2i)]" value="6" />\n}
    expected << %{<input type="hidden" id="post_updated_at_3i" name="post[updated_at(3i)]" value="1" />\n}

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", discard_month: true, use_separators: true)
  end

  def test_datetime_select_discard_year_and_month
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_updated_at_1i" name="post[updated_at(1i)]" value="2004" />\n}
    expected << %{<input type="hidden" id="post_updated_at_2i" name="post[updated_at(2i)]" value="6" />\n}
    expected << %{<input type="hidden" id="post_updated_at_3i" name="post[updated_at(3i)]" value="1" />\n}

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", discard_year: true, discard_month: true, use_separators: true)
  end

  def test_datetime_select_discard_year_and_month_with_disabled_html_option
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_updated_at_1i" disabled="disabled" name="post[updated_at(1i)]" value="2004" />\n}
    expected << %{<input type="hidden" id="post_updated_at_2i" disabled="disabled" name="post[updated_at(2i)]" value="6" />\n}
    expected << %{<input type="hidden" id="post_updated_at_3i" disabled="disabled" name="post[updated_at(3i)]" value="1" />\n}

    expected << %{<select id="post_updated_at_4i" disabled="disabled" name="post[updated_at(4i)]">\n}
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" disabled="disabled" name="post[updated_at(5i)]">\n}
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", { discard_year: true, discard_month: true, use_separators: true }, disabled: true)
  end

  def test_datetime_select_discard_hour
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    1999.upto(2009) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 2004}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    1.upto(12) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 6}>#{Date::MONTHNAMES[i]}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    1.upto(31) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 15}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", discard_hour: true, use_separators: true)
  end

  def test_datetime_select_discard_minute
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    1999.upto(2009) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 2004}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    1.upto(12) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 6}>#{Date::MONTHNAMES[i]}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    1.upto(31) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 15}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << %{<input type="hidden" id="post_updated_at_5i" name="post[updated_at(5i)]" value="16" />\n}

    assert_dom_equal expected, datetime_select("post", "updated_at", discard_minute: true, use_separators: true)
  end

  def test_datetime_select_disabled_and_discard_minute
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<select id="post_updated_at_1i" disabled="disabled" name="post[updated_at(1i)]">\n}
    1999.upto(2009) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 2004}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << %{<select id="post_updated_at_2i" disabled="disabled" name="post[updated_at(2i)]">\n}
    1.upto(12) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 6}>#{Date::MONTHNAMES[i]}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %{<select id="post_updated_at_3i" disabled="disabled" name="post[updated_at(3i)]">\n}
    1.upto(31) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 15}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" disabled="disabled" name="post[updated_at(4i)]">\n}
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << %{<input type="hidden" id="post_updated_at_5i" disabled="disabled" name="post[updated_at(5i)]" value="16" />\n}

    assert_dom_equal expected, datetime_select("post", "updated_at", discard_minute: true, disabled: true, use_separators: true)
  end

  def test_datetime_select_invalid_order
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    1.upto(31) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 15}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)
    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    1.upto(12) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 6}>#{Date::MONTHNAMES[i]}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    1999.upto(2009) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 2004}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", order: [:minute, :day, :hour, :month, :year, :second], use_separators: true)
  end

  def test_datetime_select_discard_with_order
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 15, 16, 35)

    expected = %{<input type="hidden" id="post_updated_at_1i" name="post[updated_at(1i)]" value="2004" />\n}
    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    1.upto(31) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 15}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)
    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    1.upto(12) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 6}>#{Date::MONTHNAMES[i]}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", order: [:day, :month], use_separators: true)
  end

  def test_datetime_select_with_default_value_as_time
    @post = Post.new
    @post.updated_at = nil

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    2001.upto(2011) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 2006}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    1.upto(12) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 9}>#{Date::MONTHNAMES[i]}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    1.upto(31) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 19}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", default: Time.local(2006, 9, 19, 15, 16, 35), use_separators: true)
  end

  def test_include_blank_overrides_default_option
    @post = Post.new
    @post.updated_at = nil

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    expected << %(<option value=""></option>\n)
    (Time.now.year - 5).upto(Time.now.year + 5) { |i| expected << %(<option value="#{i}">#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    expected << %(<option value=""></option>\n)
    1.upto(12) { |i| expected << %(<option value="#{i}">#{Date::MONTHNAMES[i]}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    expected << %(<option value=""></option>\n)
    1.upto(31) { |i| expected << %(<option value="#{i}">#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    assert_dom_equal expected, date_select("post", "updated_at", default: Time.local(2006, 9, 19, 15, 16, 35), include_blank: true, use_separators: true)
  end

  def test_datetime_select_with_default_value_as_hash
    @post = Post.new
    @post.updated_at = nil

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]">\n}
    (Time.now.year - 5).upto(Time.now.year + 5) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == Time.now.year}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)
    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]">\n}
    1.upto(12) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == 10}>#{Date::MONTHNAMES[i]}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)
    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]">\n}
    1.upto(31) { |i| expected << %(<option value="#{i}"#{' selected="selected"' if i == Time.now.day}>#{i}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]">\n}
    0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 9}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]">\n}
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 42}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", default: { month: 10, minute: 42, hour: 9 }, use_separators: true)
  end

  def test_datetime_select_with_html_options
    @post = Post.new
    @post.updated_at = Time.local(2004, 6, 15, 16, 35)

    expected = %{<select id="post_updated_at_1i" name="post[updated_at(1i)]" class="selector">\n}
    expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_year">yy</span>\n)

    expected << %{<select id="post_updated_at_2i" name="post[updated_at(2i)]" class="selector">\n}
    expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_month">mm</span>\n)

    expected << %{<select id="post_updated_at_3i" name="post[updated_at(3i)]" class="selector">\n}
    expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_day">dd</span>\n)

    expected << " &mdash; "

    expected << %{<select id="post_updated_at_4i" name="post[updated_at(4i)]" class="selector">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_hour">h</span>\n)
    expected << " : "
    expected << %{<select id="post_updated_at_5i" name="post[updated_at(5i)]" class="selector">\n}
    expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35" selected="selected">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
    expected << "</select>\n"
    expected << %(<span class="separator_minute">min</span>\n)

    assert_dom_equal expected, datetime_select("post", "updated_at", { use_separators: true }, class: 'selector')
  end

  def test_date_select_should_not_change_passed_options_hash
    @post = Post.new
    @post.updated_at = Time.local(2008, 7, 16, 23, 30)

    options = {
      order: [ :year, :month, :day ],
      default: { year: 2008, month: 7, day: 16, hour: 23, minute: 30, second: 1 },
      discard_type: false,
      include_blank: false,
      ignore_date: false,
      include_seconds: true,
      use_separators: true
    }
    date_select(@post, :updated_at, options)

    # note: the literal hash is intentional to show that the actual options hash isn't modified
    #       don't change this!
    assert_equal({
      order: [ :year, :month, :day ],
      default: { year: 2008, month: 7, day: 16, hour: 23, minute: 30, second: 1 },
      discard_type: false,
      include_blank: false,
      ignore_date: false,
      include_seconds: true,
      use_separators: true
    }, options)
  end

  def test_datetime_select_should_not_change_passed_options_hash
    @post = Post.new
    @post.updated_at = Time.local(2008, 7, 16, 23, 30)

    options = {
      order: [ :year, :month, :day ],
      default: { year: 2008, month: 7, day: 16, hour: 23, minute: 30, second: 1 },
      discard_type: false,
      include_blank: false,
      ignore_date: false,
      include_seconds: true,
      use_separators: true
    }
    datetime_select(@post, :updated_at, options)

    # note: the literal hash is intentional to show that the actual options hash isn't modified
    #       don't change this!
    assert_equal({
      order: [ :year, :month, :day ],
      default: { year: 2008, month: 7, day: 16, hour: 23, minute: 30, second: 1 },
      discard_type: false,
      include_blank: false,
      ignore_date: false,
      include_seconds: true,
      use_separators: true
    }, options)
  end

  def test_time_select_should_not_change_passed_options_hash
    @post = Post.new
    @post.updated_at = Time.local(2008, 7, 16, 23, 30)

    options = {
      order: [ :year, :month, :day ],
      default: { year: 2008, month: 7, day: 16, hour: 23, minute: 30, second: 1 },
      discard_type: false,
      include_blank: false,
      ignore_date: false,
      include_seconds: true,
      use_separators: true
    }
    time_select(@post, :updated_at, options)

    # note: the literal hash is intentional to show that the actual options hash isn't modified
    #       don't change this!
    assert_equal({
      order: [ :year, :month, :day ],
      default: { year: 2008, month: 7, day: 16, hour: 23, minute: 30, second: 1 },
      discard_type: false,
      include_blank: false,
      ignore_date: false,
      include_seconds: true,
      use_separators: true
    }, options)
  end

  def test_select_date_should_not_change_passed_options_hash
    options = {
      order: [ :year, :month, :day ],
      default: { year: 2008, month: 7, day: 16, hour: 23, minute: 30, second: 1 },
      discard_type: false,
      include_blank: false,
      ignore_date: false,
      include_seconds: true,
      use_separators: true
    }
    select_date(Date.today, options)

    # note: the literal hash is intentional to show that the actual options hash isn't modified
    #       don't change this!
    assert_equal({
      order: [ :year, :month, :day ],
      default: { year: 2008, month: 7, day: 16, hour: 23, minute: 30, second: 1 },
      discard_type: false,
      include_blank: false,
      ignore_date: false,
      include_seconds: true,
      use_separators: true
    }, options)
  end

  def test_select_datetime_should_not_change_passed_options_hash
    options = {
      order: [ :year, :month, :day ],
      default: { year: 2008, month: 7, day: 16, hour: 23, minute: 30, second: 1 },
      discard_type: false,
      include_blank: false,
      ignore_date: false,
      include_seconds: true,
      use_separators: true
    }
    select_datetime(Time.now, options)

    # note: the literal hash is intentional to show that the actual options hash isn't modified
    #       don't change this!
    assert_equal({
      order: [ :year, :month, :day ],
      default: { year: 2008, month: 7, day: 16, hour: 23, minute: 30, second: 1 },
      discard_type: false,
      include_blank: false,
      ignore_date: false,
      include_seconds: true,
      use_separators: true
    }, options)
  end

  def test_select_time_should_not_change_passed_options_hash
    options = {
      order: [ :year, :month, :day ],
      default: { year: 2008, month: 7, day: 16, hour: 23, minute: 30, second: 1 },
      discard_type: false,
      include_blank: false,
      ignore_date: false,
      include_seconds: true,
      use_separators: true
    }
    select_time(Time.now, options)

    # note: the literal hash is intentional to show that the actual options hash isn't modified
    #       don't change this!
    assert_equal({
      order: [ :year, :month, :day ],
      default: { year: 2008, month: 7, day: 16, hour: 23, minute: 30, second: 1 },
      discard_type: false,
      include_blank: false,
      ignore_date: false,
      include_seconds: true,
      use_separators: true
    }, options)
  end

  def test_select_html_safety
    assert select_day(16, use_separators: true).html_safe?
    assert select_month(8, use_separators: true).html_safe?
    assert select_year(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: true).html_safe?
    assert select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: true).html_safe?
    assert select_second(Time.mktime(2003, 8, 16, 8, 4, 18), use_separators: true).html_safe?

    assert select_minute(8, use_hidden: true, use_separators: true).html_safe?
    assert select_month(8, prompt: 'Choose month', use_separators: true).html_safe?

    assert select_time(Time.mktime(2003, 8, 16, 8, 4, 18), { use_separators: true }, class: 'selector').html_safe?
    assert select_date(Time.mktime(2003, 8, 16), date_separator: " / ", start_year: 2003, end_year: 2005, prefix: "date[first]", use_separators: true).html_safe?
  end

  def test_object_select_html_safety
    @post = Post.new
    @post.written_on = Date.new(2004, 6, 15)

    assert date_select("post", "written_on", default: Time.local(2006, 9, 19, 15, 16, 35), include_blank: true, use_separators: true).html_safe?
    assert time_select("post", "written_on", ignore_date: true, use_separators: true).html_safe?
  end

  def test_time_tag_with_date
    date = Date.new(2013, 2, 20)
    expected = '<time datetime="2013-02-20">February 20, 2013</time>'
    assert_equal expected, time_tag(date)
  end

  def test_time_tag_with_time
    time = Time.new(2013, 2, 20, 0, 0, 0, '+00:00')
    expected = '<time datetime="2013-02-20T00:00:00+00:00">February 20, 2013 00:00</time>'
    assert_equal expected, time_tag(time)
  end

  def test_time_tag_pubdate_option
    assert_match(/<time.*pubdate="pubdate">.*<\/time>/, time_tag(Time.now, :pubdate => true))
  end

  def test_time_tag_with_given_text
    assert_match(/<time.*>Right now<\/time>/, time_tag(Time.now, 'Right now'))
  end

  def test_time_tag_with_given_block
    assert_match(/<time.*><span>Right now<\/span><\/time>/, time_tag(Time.now){ '<span>Right now</span>'.html_safe })
  end

  def test_time_tag_with_different_format
    time = Time.new(2013, 2, 20, 0, 0, 0, '+00:00')
    expected = '<time datetime="2013-02-20T00:00:00+00:00">20 Feb 00:00</time>'
    assert_equal expected, time_tag(time, :format => :short)
  end

  if Rails::VERSION::STRING >= '5'
    def test_select_day_with_generic_with_css_classes
      expected = %(<select id="date_day" name="date[day]" class="day">\n)
      expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_day(16, with_css_classes: true)
    end

    def test_select_day_with_custom_with_css_classes
      expected = %(<select id="date_day" name="date[day]" class="my-day">\n)
      expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_day(16, with_css_classes: { day: 'my-day' })
    end

    def test_select_month_with_generic_with_css_classes
      expected = %(<select id="date_month" name="date[month]" class="month">\n)
      expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_month(8, with_css_classes: true)
    end

    def test_select_month_with_custom_with_css_classes
      expected = %(<select id="date_month" name="date[month]" class="my-month">\n)
      expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_month(8, with_css_classes: { month: 'my-month' })
    end

    def test_select_year_with_generic_with_css_classes
      expected = %(<select id="date_year" name="date[year]" class="year">\n)
      expected << %(<option value="2003">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_year(nil, start_year: 2003, end_year: 2005, with_css_classes: true)
    end

    def test_select_year_with_custom_with_css_classes
      expected = %(<select id="date_year" name="date[year]" class="my-year">\n)
      expected << %(<option value="2003">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_year(nil, start_year: 2003, end_year: 2005, with_css_classes: { year: 'my-year' })
    end

    def test_select_hour_with_generic_with_css_classes
      expected = %(<select id="date_hour" name="date[hour]" class="hour">\n)
      expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), with_css_classes: true)
    end

    def test_select_hour_with_custom_with_css_classes
      expected = %(<select id="date_hour" name="date[hour]" class="my-hour">\n)
      expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_hour(Time.mktime(2003, 8, 16, 8, 4, 18), with_css_classes: { hour: 'my-hour' })
    end

    def test_select_minute_with_generic_with_css_classes
      expected = %(<select id="date_minute" name="date[minute]" class="minute">\n)
      expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), with_css_classes: true)
    end

    def test_select_minute_with_custom_with_css_classes
      expected = %(<select id="date_minute" name="date[minute]" class="my-minute">\n)
      expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_minute(Time.mktime(2003, 8, 16, 8, 4, 18), with_css_classes: { minute: 'my-minute' })
    end

    def test_select_second_with_generic_with_css_classes
      expected = %(<select id="date_second" name="date[second]" class="second">\n)
      expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18" selected="selected">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_second(Time.mktime(2003, 8, 16, 8, 4, 18), with_css_classes: true)
    end

    def test_select_second_with_custom_with_css_classes
      expected = %(<select id="date_second" name="date[second]" class="my-second">\n)
      expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18" selected="selected">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_second(Time.mktime(2003, 8, 16, 8, 4, 18), with_css_classes: { second: 'my-second' })
    end

    def test_select_date_with_custom_with_css_classes
      expected =  %(<select id="date_year" name="date[year]" class="my-year">\n)
      expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
      expected << "</select>\n"

      expected << %(<select id="date_month" name="date[month]" class="my-month">\n)
      expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
      expected << "</select>\n"

      expected << %(<select id="date_day" name="date[day]" class="my-day">\n)
      expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), start_year: 2003, end_year: 2005, with_css_classes: { year: 'my-year', month: 'my-month', day: 'my-day' })
    end


    def test_select_date_with_custom_with_css_classes_and_html_class_option
      expected =  %(<select id="date_year" name="date[year]" class="date optional my-year">\n)
      expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
      expected << "</select>\n"

      expected << %(<select id="date_month" name="date[month]" class="date optional my-month">\n)
      expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
      expected << "</select>\n"

      expected << %(<select id="date_day" name="date[day]" class="date optional my-day">\n)
      expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), {start_year: 2003, end_year: 2005, with_css_classes: { year: 'my-year', month: 'my-month', day: 'my-day' }}, { class: 'date optional' })
    end

    def test_select_date_with_partial_with_css_classes_and_html_class_option
      expected =  %(<select id="date_year" name="date[year]" class="date optional">\n)
      expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
      expected << "</select>\n"

      expected << %(<select id="date_month" name="date[month]" class="date optional my-month custom-grid">\n)
      expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
      expected << "</select>\n"

      expected << %(<select id="date_day" name="date[day]" class="date optional">\n)
      expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), {start_year: 2003, end_year: 2005, with_css_classes: { month: 'my-month custom-grid' }}, { class: 'date optional' })
    end

    def test_select_date_with_html_class_option
      expected =  %(<select id="date_year" name="date[year]" class="date optional custom-grid">\n)
      expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
      expected << "</select>\n"

      expected << %(<select id="date_month" name="date[month]" class="date optional custom-grid">\n)
      expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
      expected << "</select>\n"

      expected << %(<select id="date_day" name="date[day]" class="date optional custom-grid">\n)
      expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_date(Time.mktime(2003, 8, 16), { start_year: 2003, end_year: 2005 }, { class: 'date optional custom-grid' })
    end

    def test_select_datetime_with_generic_with_css_classes
      expected =  %(<select id="date_year" name="date[year]" class="year">\n)
      expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
      expected << "</select>\n"

      expected << %(<select id="date_month" name="date[month]" class="month">\n)
      expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
      expected << "</select>\n"

      expected << %(<select id="date_day" name="date[day]" class="day">\n)
      expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
      expected << "</select>\n"

      expected << " &mdash; "

      expected << %(<select id="date_hour" name="date[hour]" class="hour">\n)
      expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
      expected << "</select>\n"

      expected << " : "
      expected << %(<select id="date_minute" name="date[minute]" class="minute">\n)
      expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), start_year: 2003, end_year: 2005, with_css_classes: true)
    end

    def test_select_datetime_with_custom_with_css_classes
      expected =  %(<select id="date_year" name="date[year]" class="my-year">\n)
      expected << %(<option value="2003" selected="selected">2003</option>\n<option value="2004">2004</option>\n<option value="2005">2005</option>\n)
      expected << "</select>\n"

      expected << %(<select id="date_month" name="date[month]" class="my-month">\n)
      expected << %(<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6">June</option>\n<option value="7">July</option>\n<option value="8" selected="selected">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n)
      expected << "</select>\n"

      expected << %(<select id="date_day" name="date[day]" class="my-day">\n)
      expected << %(<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n)
      expected << "</select>\n"

      expected << " &mdash; "

      expected << %(<select id="date_hour" name="date[hour]" class="my-hour">\n)
      expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
      expected << "</select>\n"

      expected << " : "

      expected << %(<select id="date_minute" name="date[minute]" class="my-minute">\n)
      expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_datetime(Time.mktime(2003, 8, 16, 8, 4, 18), start_year: 2003, end_year: 2005, with_css_classes: { day: 'my-day', month: 'my-month', year: 'my-year', hour: 'my-hour', minute: 'my-minute' })
    end

    def test_select_time_with_generic_with_css_classes
      expected  = %(<input name="date[year]" id="date_year" value="2003" type="hidden" />\n)
      expected << %(<input name="date[month]" id="date_month" value="8" type="hidden" />\n)
      expected << %(<input name="date[day]" id="date_day" value="16" type="hidden" />\n)

      expected << %(<select id="date_hour" name="date[hour]" class="hour">\n)
      expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
      expected << "</select>\n"

      expected << " : "

      expected << %(<select id="date_minute" name="date[minute]" class="minute">\n)
      expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
      expected << "</select>\n"

      expected << " : "
      expected << %(<select id="date_second" name="date[second]" class="second">\n)
      expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18" selected="selected">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), include_seconds: true, with_css_classes: true)
    end

    def test_select_time_with_custom_with_css_classes
      expected  = %(<input name="date[year]" id="date_year" value="2003" type="hidden" />\n)
      expected << %(<input name="date[month]" id="date_month" value="8" type="hidden" />\n)
      expected << %(<input name="date[day]" id="date_day" value="16" type="hidden" />\n)

      expected << %(<select id="date_hour" name="date[hour]" class="my-hour">\n)
      expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08" selected="selected">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n)
      expected << "</select>\n"

      expected << " : "
      expected << %(<select id="date_minute" name="date[minute]" class="my-minute">\n)
      expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04" selected="selected">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
      expected << "</select>\n"

      expected << " : "

      expected << %(<select id="date_second" name="date[second]" class="my-second">\n)
      expected << %(<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18" selected="selected">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n)
      expected << "</select>\n"

      assert_dom_equal expected, select_time(Time.mktime(2003, 8, 16, 8, 4, 18), include_seconds: true, with_css_classes: { hour: 'my-hour', minute: 'my-minute', second: 'my-second' })
    end

    def test_date_select_with_generic_with_css_classes
      @post = Post.new
      @post.written_on = Date.new(2004, 6, 15)

      expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]" class="year">\n}
      expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
      expected << "</select>\n"

      expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]" class="month">\n}
      expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
      expected << "</select>\n"

      expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]" class="day">\n}
      expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}

      expected << "</select>\n"

      assert_dom_equal expected, date_select("post", "written_on", with_css_classes: true)
    end

    def test_date_select_with_custom_with_css_classes
      @post = Post.new
      @post.written_on = Date.new(2004, 6, 15)

      expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]" class="my-year">\n}
      expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
      expected << "</select>\n"

      expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]" class="my-month">\n}
      expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
      expected << "</select>\n"

      expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]" class="my-day">\n}
      expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}

      expected << "</select>\n"

      assert_dom_equal expected, date_select("post", "written_on", with_css_classes: { year: 'my-year', month: 'my-month', day: 'my-day' })
    end

    def test_time_select_with_generic_with_css_classes
      @post = Post.new
      @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

      expected = %{<input type="hidden" id="post_written_on_1i" name="post[written_on(1i)]" value="2004" />\n}
      expected << %{<input type="hidden" id="post_written_on_2i" name="post[written_on(2i)]" value="6" />\n}
      expected << %{<input type="hidden" id="post_written_on_3i" name="post[written_on(3i)]" value="15" />\n}

      expected << %(<select id="post_written_on_4i" name="post[written_on(4i)]" class="hour">\n)
      0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
      expected << "</select>\n"

      expected << " : "

      expected << %(<select id="post_written_on_5i" name="post[written_on(5i)]" class="minute">\n)
      0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
      expected << "</select>\n"

      assert_dom_equal expected, time_select("post", "written_on", with_css_classes: true)
    end

    def test_time_select_with_custom_with_css_classes
      @post = Post.new
      @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

      expected = %{<input type="hidden" id="post_written_on_1i" name="post[written_on(1i)]" value="2004" />\n}
      expected << %{<input type="hidden" id="post_written_on_2i" name="post[written_on(2i)]" value="6" />\n}
      expected << %{<input type="hidden" id="post_written_on_3i" name="post[written_on(3i)]" value="15" />\n}

      expected << %(<select id="post_written_on_4i" name="post[written_on(4i)]" class="my-hour">\n)
      0.upto(23) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 15}>#{sprintf("%02d", i)}</option>\n) }
      expected << "</select>\n"

      expected << " : "

      expected << %(<select id="post_written_on_5i" name="post[written_on(5i)]" class="my-minute">\n)
      0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 16}>#{sprintf("%02d", i)}</option>\n) }
      expected << "</select>\n"

      assert_dom_equal expected, time_select("post", "written_on", with_css_classes: { hour: 'my-hour', minute: 'my-minute' })
    end

    def test_datetime_select_with_generic_with_css_classes
      @post = Post.new
      @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

      expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]" class="year">\n}
      expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
      expected << "</select>\n"

      expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]" class="month">\n}
      expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
      expected << "</select>\n"

      expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]" class="day">\n}
      expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
      expected << "</select>\n"

      expected << " &mdash; "
      expected << %{<select id="post_written_on_4i" name="post[written_on(4i)]" class="hour">\n}
      expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
      expected << "</select>\n"
      expected << " : "
      expected << %{<select id="post_written_on_5i" name="post[written_on(5i)]" class="minute">\n}
      expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
      expected << "</select>\n"

      assert_dom_equal expected, datetime_select("post", "written_on", start_year: 1999, end_year: 2009, with_css_classes: true)
    end

    def test_datetime_select_with_custom_with_css_classes
      @post = Post.new
      @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

      expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]" class="my-year">\n}
      expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
      expected << "</select>\n"

      expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]" class="my-month">\n}
      expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
      expected << "</select>\n"

      expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]" class="my-day">\n}
      expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
      expected << "</select>\n"

      expected << " &mdash; "
      expected << %{<select id="post_written_on_4i" name="post[written_on(4i)]" class="my-hour">\n}
      expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
      expected << "</select>\n"
      expected << " : "
      expected << %{<select id="post_written_on_5i" name="post[written_on(5i)]" class="my-minute">\n}
      expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
      expected << "</select>\n"

      assert_dom_equal expected, datetime_select("post", "written_on", start_year: 1999, end_year: 2009, with_css_classes: { year: 'my-year', month: 'my-month', day: 'my-day', hour: 'my-hour', minute: 'my-minute' })
    end

    def test_date_select_with_generic_with_css_classes_and_custom_separator
      @post = Post.new
      @post.written_on = Date.new(2004, 6, 15)

      expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]" class="year">\n}
      expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
      expected << "</select>\n"
      expected << %{<span class="separator_year">yy</span>\n}

      expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]" class="month">\n}
      expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
      expected << "</select>\n"
      expected << %{<span class="separator_month">mm</span>\n}

      expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]" class="day">\n}
      expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}

      expected << "</select>\n"
      expected << %{<span class="separator_day">dd</span>\n}

      assert_dom_equal expected, date_select("post", "written_on", with_css_classes: true, use_separators: true)
    end

    def test_datetime_select_with_generic_with_css_classes_and_custom_separator
      @post = Post.new
      @post.written_on = Time.local(2004, 6, 15, 15, 16, 35)

      expected = %{<select id="post_written_on_1i" name="post[written_on(1i)]" class="year">\n}
      expected << %{<option value="1999">1999</option>\n<option value="2000">2000</option>\n<option value="2001">2001</option>\n<option value="2002">2002</option>\n<option value="2003">2003</option>\n<option value="2004" selected="selected">2004</option>\n<option value="2005">2005</option>\n<option value="2006">2006</option>\n<option value="2007">2007</option>\n<option value="2008">2008</option>\n<option value="2009">2009</option>\n}
      expected << "</select>\n"
      expected << %{<span class="separator_year">yy</span>\n}

      expected << %{<select id="post_written_on_2i" name="post[written_on(2i)]" class="month">\n}
      expected << %{<option value="1">January</option>\n<option value="2">February</option>\n<option value="3">March</option>\n<option value="4">April</option>\n<option value="5">May</option>\n<option value="6" selected="selected">June</option>\n<option value="7">July</option>\n<option value="8">August</option>\n<option value="9">September</option>\n<option value="10">October</option>\n<option value="11">November</option>\n<option value="12">December</option>\n}
      expected << "</select>\n"
      expected << %{<span class="separator_month">mm</span>\n}

      expected << %{<select id="post_written_on_3i" name="post[written_on(3i)]" class="day">\n}
      expected << %{<option value="1">1</option>\n<option value="2">2</option>\n<option value="3">3</option>\n<option value="4">4</option>\n<option value="5">5</option>\n<option value="6">6</option>\n<option value="7">7</option>\n<option value="8">8</option>\n<option value="9">9</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n}
      expected << "</select>\n"
      expected << %{<span class="separator_day">dd</span>\n}

      expected << " &mdash; "
      expected << %{<select id="post_written_on_4i" name="post[written_on(4i)]" class="hour">\n}
      expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15" selected="selected">15</option>\n<option value="16">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n}
      expected << "</select>\n"
      expected << %{<span class="separator_hour">h</span>\n}
      expected << " : "
      expected << %{<select id="post_written_on_5i" name="post[written_on(5i)]" class="minute">\n}
      expected << %{<option value="00">00</option>\n<option value="01">01</option>\n<option value="02">02</option>\n<option value="03">03</option>\n<option value="04">04</option>\n<option value="05">05</option>\n<option value="06">06</option>\n<option value="07">07</option>\n<option value="08">08</option>\n<option value="09">09</option>\n<option value="10">10</option>\n<option value="11">11</option>\n<option value="12">12</option>\n<option value="13">13</option>\n<option value="14">14</option>\n<option value="15">15</option>\n<option value="16" selected="selected">16</option>\n<option value="17">17</option>\n<option value="18">18</option>\n<option value="19">19</option>\n<option value="20">20</option>\n<option value="21">21</option>\n<option value="22">22</option>\n<option value="23">23</option>\n<option value="24">24</option>\n<option value="25">25</option>\n<option value="26">26</option>\n<option value="27">27</option>\n<option value="28">28</option>\n<option value="29">29</option>\n<option value="30">30</option>\n<option value="31">31</option>\n<option value="32">32</option>\n<option value="33">33</option>\n<option value="34">34</option>\n<option value="35">35</option>\n<option value="36">36</option>\n<option value="37">37</option>\n<option value="38">38</option>\n<option value="39">39</option>\n<option value="40">40</option>\n<option value="41">41</option>\n<option value="42">42</option>\n<option value="43">43</option>\n<option value="44">44</option>\n<option value="45">45</option>\n<option value="46">46</option>\n<option value="47">47</option>\n<option value="48">48</option>\n<option value="49">49</option>\n<option value="50">50</option>\n<option value="51">51</option>\n<option value="52">52</option>\n<option value="53">53</option>\n<option value="54">54</option>\n<option value="55">55</option>\n<option value="56">56</option>\n<option value="57">57</option>\n<option value="58">58</option>\n<option value="59">59</option>\n}
      expected << "</select>\n"
      expected << %{<span class="separator_minute">min</span>\n}

      assert_dom_equal expected, datetime_select("post", "written_on", start_year: 1999, end_year: 2009, with_css_classes: true, use_separators: true)
    end
  end
end
