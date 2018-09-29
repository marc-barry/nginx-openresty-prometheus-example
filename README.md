# nginx-openresty-prometheus-example
Prometheus metrics for NGINX using OpenResty.

# Overview
This project illustrates the use of OpenResty to produce Prometheus metrics. It leverages https://github.com/knyar/nginx-lua-prometheus
and [OpenResty](https://openresty.org). The base image is from https://github.com/marc-barry/docker-nginx-openresty which
is a Docker image with some OpenResty components. The base image is available on [Docker Hub](https://hub.docker.com/r/middlenamesfirst/docker-nginx-openresty/).

# Usage
To build the image:
```
make image
```

To run the image:
```
make run
```

Upon running the image one can obtain the Prometheus metrics at the `/metrics` endpoint.
```
~ ❯ curl http://localhost:9145/metrics
# HELP nginx_http_connections Number of HTTP connections
# TYPE nginx_http_connections gauge
nginx_http_connections{state="active"} 1
nginx_http_connections{state="reading"} 0
nginx_http_connections{state="waiting"} 0
nginx_http_connections{state="writing"} 1
# HELP nginx_metric_errors_total Number of nginx-lua-prometheus errors
# TYPE nginx_metric_errors_total counter
nginx_metric_errors_total 0
```

There are some example endpoints which can be queried to produce results which contain different HTTP status codes:
```
~ ❯ curl http://localhost/200
~ ❯ curl http://localhost/404
<html>
<head><title>404 Not Found</title></head>
<body>
<center><h1>404 Not Found</h1></center>
<hr><center>nginx/1.15.4</center>
</body>
</html>
~ ❯ curl http://localhost/500
<html>
<head><title>500 Internal Server Error</title></head>
<body>
<center><h1>500 Internal Server Error</h1></center>
<hr><center>nginx/1.15.4</center>
</body>
</html>
~ ❯ curl http://localhost/501
<html>
<head><title>501 Not Implemented</title></head>
<body>
<center><h1>501 Not Implemented</h1></center>
<hr><center>nginx/1.15.4</center>
</body>
</html>
~ ❯ curl http://localhost:9145/metrics
# HELP nginx_http_connections Number of HTTP connections
# TYPE nginx_http_connections gauge
nginx_http_connections{state="active"} 1
nginx_http_connections{state="reading"} 0
nginx_http_connections{state="waiting"} 0
nginx_http_connections{state="writing"} 1
# HELP nginx_http_request_duration_seconds HTTP request latency
# TYPE nginx_http_request_duration_seconds histogram
nginx_http_request_duration_seconds_bucket{host="",le="00.005"} 5
nginx_http_request_duration_seconds_bucket{host="",le="00.010"} 5
nginx_http_request_duration_seconds_bucket{host="",le="00.020"} 5
nginx_http_request_duration_seconds_bucket{host="",le="00.030"} 5
nginx_http_request_duration_seconds_bucket{host="",le="00.050"} 5
nginx_http_request_duration_seconds_bucket{host="",le="00.075"} 5
nginx_http_request_duration_seconds_bucket{host="",le="00.100"} 5
nginx_http_request_duration_seconds_bucket{host="",le="00.200"} 5
nginx_http_request_duration_seconds_bucket{host="",le="00.300"} 5
nginx_http_request_duration_seconds_bucket{host="",le="00.400"} 5
nginx_http_request_duration_seconds_bucket{host="",le="00.500"} 5
nginx_http_request_duration_seconds_bucket{host="",le="00.750"} 5
nginx_http_request_duration_seconds_bucket{host="",le="01.000"} 5
nginx_http_request_duration_seconds_bucket{host="",le="01.500"} 5
nginx_http_request_duration_seconds_bucket{host="",le="02.000"} 5
nginx_http_request_duration_seconds_bucket{host="",le="03.000"} 5
nginx_http_request_duration_seconds_bucket{host="",le="04.000"} 5
nginx_http_request_duration_seconds_bucket{host="",le="05.000"} 5
nginx_http_request_duration_seconds_bucket{host="",le="10.000"} 5
nginx_http_request_duration_seconds_bucket{host="",le="+Inf"} 5
nginx_http_request_duration_seconds_count{host=""} 5
nginx_http_request_duration_seconds_sum{host=""} 0
# HELP nginx_http_requests_total Number of HTTP requests
# TYPE nginx_http_requests_total counter
nginx_http_requests_total{host="",status="200"} 2
nginx_http_requests_total{host="",status="404"} 1
nginx_http_requests_total{host="",status="500"} 1
nginx_http_requests_total{host="",status="501"} 1
# HELP nginx_metric_errors_total Number of nginx-lua-prometheus errors
# TYPE nginx_metric_errors_total counter
nginx_metric_errors_total 0
```