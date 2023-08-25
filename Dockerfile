FROM golang:1.21 AS build

WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -a -installsuffix cgo -o chatline .

FROM arm64v8/alpine:latest
COPY --from=build /app/chatline chatline
EXPOSE 8080
CMD ["/chatline"]
