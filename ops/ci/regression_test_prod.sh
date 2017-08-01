cd regression-test

set -e

# On the build server Python is unable to be installed to
# By doing --user we install the packages locally
pip install --user -r requirements.txt

# In prod just run the pvt tests only.Not running the smoke test as it is not required in prod

xvfb-run -a behave --junit -t ~wip -t pvt -D url_to_test=unitguidemanager.monash.edu
