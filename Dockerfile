FROM py_alpine_dev_3.7

MAINTAINER Pampa Nie "nxg@lohosoft.com"

ARG USER_ID
ARG GROUP_ID

# Copy source to container
RUN mkdir -p /usr/app/src
RUN mkdir -p /usr/app/data

COPY . /usr/app

WORKDIR /usr/app


# update mark
RUN echo "2020031401" >> /dev/null

# install with local servers
RUN pip3 install -r requirements.txt -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
# RUN pip3 install -r requirements.txt

# Create a user group 
RUN addgroup $GROUP_ID

# Create a user under group
RUN adduser -S -D -h /usr/app/ $USER_ID $GROUP_ID

# Chown all the files to the app user.
RUN chown -R $USER_ID:$GROUP_ID /usr/app

# Switch to user
USER $USER_ID

# Open the mapped port
#EXPOSE 3000


#ENTRYPOINT [ "python3" ]

#CMD [ "app/app.py" ]

# CMD [ "/bin/sh" ]

CMD ["python","src/main.py"]