FROM python:3.3

RUN pip install dnspython3 blessings
COPY dnsdiff .
RUN chmod a+x dnsdiff

ENTRYPOINT [ "./dnsdiff" ]


