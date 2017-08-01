import requests
from hamcrest import assert_that, equal_to, is_not, starts_with, ends_with

@given(u'we are validating the system')
def step_impl(context):
    pass

@when(u'we load the homepage')
def step_impl(context):
    context.response = requests.get(context.SITE_UNDER_TEST, timeout=0.500)
    print(context.response)

@when(u'we load the health check')
def step_impl(context):
    context.response = requests.get(context.SITE_UNDER_TEST+"health/status", timeout=0.500)
    print(context.response)

@then(u'the server will respond')
def step_impl(context):
    assert_that(context.response.status_code, equal_to(200))

@then(u'the server will respond successfully')
def step_impl(context):
    assert_that(context.response.status_code, equal_to(200))
