FROM golang:1.16.4 AS build

WORKDIR /go/src/test
COPY . /go/src/test
RUN go env -w GOPROXY=https://goproxy.cn,direct
RUN CGO_ENABLED=0 go build -v -o main .

FROM alpine AS api
RUN mkdir /app
COPY --from=build /go/src/test/main /app
WORKDIR /app
ENTRYPOINT ["./main", "-v" ,"1.3"]