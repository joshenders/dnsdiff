FROM python:3.3

RUN pip install \
    blessings \
    dnspython3

COPY dnsdiff .
RUN chmod +x dnsdiff

ENTRYPOINT [ "./dnsdiff" ]
