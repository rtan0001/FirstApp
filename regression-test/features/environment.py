from selenium import webdriver



def before_all(context):

    the_url = context.config.userdata['url_to_test']

    context.SITE_UNDER_TEST="https://{}/".format(the_url)
    context.SITE_UNAUTHORISED='http://google.com/'
    context.AUTH_DOMAIN_ROOT='http://cas-do-not-use-in-prod.its.monash.edu:8080/'

    context.browser = webdriver.Chrome()
    context.browser.implicitly_wait(10)

def after_all(context):
    context.browser.quit()
