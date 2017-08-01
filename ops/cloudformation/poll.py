import requests
from time import sleep

url = "http://ugm.corp-dev.aws.monash.edu"

for i in range(0, 240, 2):
    try:
        r = requests.get(url)
        if r.status_code is not 200:
            print "UNABLE TO REACH APP ({})".format(r.status_code)
            # raise requests.ConnectionError("Unable to reach {0}".format(url))
        else:
            print 200
    except Exception as e:
        print e.message
    sleep(2)

print "Success"
