FROM ubuntu:jammy

# update and download the necessary packages
RUN apt-get update 
RUN apt-get install -y git python2.7 python3-pip virtualenv python3.10-venv
RUN git clone https://github.com/dpcyber/cbc-syslog
WORKDIR /cbc-syslog

# setup python virtual environment
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# install cbc-syslog
RUN pip install -r requirements.txt
RUN pip install cbc-syslog

# switch to the installed directory
WORKDIR /opt/venv/lib/python3.10/site-packages/cbc_syslog

# setup some folders and log file
RUN mkdir logs \
    && mkdir config \
    && touch logs/cbc_syslog_logs.txt

# run the python command
CMD python3 cbc_syslog.py -l logs/cbc_syslog_logs.txt -c config/cb-defense-syslog.conf
