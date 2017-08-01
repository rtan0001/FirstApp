cd regression-test

set -e

# On the build server Python is unable to be installed to
# By doing --user we install the packages locally
pip install --user -r requirements.txt

xvfb-run -a behave --junit -t ~wip -D url_to_test=ugm.corp-dev.aws.monash.edu features/smoke.feature

# And because the packages are local, the behave command is not in the path
# Using the fully qualified path fixes the issue
xvfb-run -a behave --junit -t ~wip -D url_to_test=ugm.corp-dev.aws.monash.edu
