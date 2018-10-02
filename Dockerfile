FROM midsw205/base
MAINTAINER Tim Slade <tslade@berkeley.edu>
USER root

# Set location of Google Cloud service account key
ENV GOOGLE_APPLICATION_CREDENTIALS /w205/glass-badge-215304-1a6cd22802b8.json

# Workaround script to set aliases
RUN echo '#!/bin/bash\necho hello' > /usr/bin/hi && \
    chmod +x /usr/bin/hi

RUN echo '#!/bin/bash\njupyter notebook --no-browser --port 8888 --ip=0.0.0.0 --allow-root' > /usr/bin/startjupyter && \
    chmod +x /usr/bin/startjupyter

RUN echo '#!/bin/bash\ndocker run -it --rm -p 8888:8888 -v ~/w205:/w205 mids_ts:latest bash' > /usr/bin/slade_docker && \
    chmod +x /usr/bin/slade_docker

# Make sure BigQuery client library is installed
# Must run `pip3` because Docker image also contains Python 2.7
RUN apt-get update \
    && pip3 install --upgrade google-cloud-bigquery[pandas] \
    && pip3 install --upgrade altair
