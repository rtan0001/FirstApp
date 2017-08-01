FROM selenium/standalone-chrome

USER root

RUN apt-get update
RUN apt-get -y install python

RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py

ADD requirements.txt /opt/tests/requirements.txt
RUN cd /opt/tests && pip install -r requirements.txt

ADD features /opt/tests/features
ADD behave.ini /opt/tests/

RUN cd /opt/tests  && behave --junit -t ~wip -D environment=ugm4
