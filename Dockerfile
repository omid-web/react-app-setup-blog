FROM alpine:3.16.2 AS builder

# Installing the necessary packages
RUN apk add --update npm

# Copying the source files and building
RUN mkdir -p /opt/build_dir
COPY . /opt/build_dir
WORKDIR /opt/build_dir
RUN npm install
RUN npm run-script build

FROM alpine:3.16.2

RUN apk add --update npm
RUN apk add curl
RUN npm install -g serve

# Setting of environment variables
ENV PORT=3000
ENV HOME_FOLDER=/home/reactserving

# Creating a separate user
RUN addgroup -S reactserving
RUN adduser -S reactserving -G reactserving

# Copying the build folder into the home folder
COPY --from=builder /opt/build_dir/build $HOME_FOLDER/build

# Setting the necessary permissions
RUN chown -R reactserving:reactserving $HOME_FOLDER/build

# Adding a healthcheck, which checks if the app is listening on the specified port
HEALTHCHECK CMD \
            curl -f localhost:$PORT

# Changing the user
USER reactserving

EXPOSE $PORT

CMD serve -s -l $PORT $HOME_FOLDER/build