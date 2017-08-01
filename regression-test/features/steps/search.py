from behave import *
from hamcrest import assert_that, equal_to, is_not, starts_with, ends_with, contains_string

@given(u'they select the year "{year}"')
def select_the_year(context, year):
    all_years_label = context.browser.find_elements_by_css_selector(".selectAll.yearItemLabel")[0]
    all_years_label.click()
    all_years_label.click()
    year_label = context.browser.find_element_by_xpath("//label[@class='yearItemLabel'][text()[contains(.,'" + year + "')]]")
    year_label.click()

@given(u'they search for "{unit}"')
@when(u'they search for "{unit}"')
def search_for_unit(context, unit):
    search_input = context.browser.find_element_by_name("searchQuery")
    search_input.send_keys(unit)
    search_button = context.browser.find_element_by_class_name("search-icon")
    search_button.click()

@then(u'"{expected_unit}" does not appear in the search results')
def step_impl(context, expected_unit):
    results_text = context.browser.find_element_by_id("results").text
    assert_that(results_text, is_not(contains_string(expected_unit)))

@then(u'"{expected_unit}" appears in the search results')
def step_impl(context, expected_unit):
    results_text = context.browser.find_element_by_id("results").text
    assert_that(results_text, (contains_string(expected_unit)))

@when(u'they download the unit guide')
def step_impl(context):
    search_results = context.browser.find_element_by_class_name("resultTitle")
    search_results.click()
    download_button = context.browser.find_element_by_class_name("downloadPDF")
    download_button.click()

@then(u'the pdf is downloaded')
def step_impl(context):

    # How do we validate the PDF is downloaded?
    pass
