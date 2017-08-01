from behave import *
from hamcrest import assert_that, equal_to, is_not, starts_with, ends_with


@given(u'they are logged out')
def step_impl(context):

    context.browser.get(context.SITE_UNDER_TEST)
    context.browser.delete_all_cookies()

    context.browser.get(context.AUTH_DOMAIN_ROOT)
    context.browser.delete_all_cookies()

@given(u'a user is configured as a UGM Administrator')
def configure_as_administrator(context):
    context.username = "jielin"
    context.password = "Password123"

@given(u'a user is configured as a General UGM User')
def configure_as_unauthorised(context):
    context.username = "general"
    context.password = "Password123"

@given(u'a user is NOT configured as a General UGM User')
def configure_as_unauthorised(context):
    context.username = "unauthorised"
    context.password = "Password123"

@given(u'they login to the UGM Application')
@when(u'they login to the UGM Application')
def step_impl(context):

    context.browser.get(context.SITE_UNDER_TEST)

    element = context.browser.find_element_by_name("username")
    element.send_keys(context.username)

    element = context.browser.find_element_by_name("password")
    element.send_keys(context.password)

    button = context.browser.find_element_by_xpath('//input[@type="submit"]')
    button.click()

    assert_that(context.browser.title, starts_with("Unit Guide Manager"))

@then(u'they can access the UGM Administrator functions')
def step_impl(context):

    element = context.browser.find_element_by_xpath('//h2')
    assert_that(element.text, equal_to("Teaching Periods"))

@then(u'they cannot access the UGM Administrator functions')
def step_impl(context):

    element = context.browser.find_element_by_xpath('//h2')
    assert_that(context.browser.current_url, ends_with("/search"))
    assert_that(element.text, equal_to("Find a unit guide"))

@then(u'they are denied access')
def step_impl(context):
    assert_that(context.browser.current_url, equal_to(context.SITE_UNAUTHORISED))
