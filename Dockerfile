FROM golang:alpine as builder

LABEL maintainer="pratheesh pc <pratheeshpcpalappetta@gmail.com>"

WORKDIR /app

COPY go.mod /app/
COPY *.go /app/

RUN go mod download

RUN go build -o cmd /app/main.go


# generate clean, final image for end users
FROM alpine:3.11.3

# Create a non-root user with a home directory
RUN adduser -D non_root_user

# Set the working directory to the home directory of the non-root user
WORKDIR /home/non_root_user

# Copy everything into non_root_user
COPY --from=builder /app/cmd .

# Set the ownership and permissions of the execution binary file
RUN chown non_root_user:non_root_user /home/non_root_user/cmd && \
    chmod 500 /home/non_root_user/cmd

# Switch to the non-root user
USER non_root_user

# Expose the port that the echo service listens on
EXPOSE 8080

# Start the service
CMD ["./cmd"]
