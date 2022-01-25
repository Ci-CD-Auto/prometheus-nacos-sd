# prometheus-nacos-sd [[中文介绍](README_cn.md)]

Prometheus service discovery using nacos and `file_sd_config`.

----
## Install

### Docker

```
docker pull houshuai0816/prometheus-nacos-sd:1.0.0
docker run -it -d -v /tmp:/tmp --name prometheus-nacos-sd houshuai0816/prometheus-nacos-sd:1.0.0 --nacos.address=192.168.1.1:8848 --nacos.namespaceId=6440ac2f-470c-42f4-a845-d6fc7186edbc --output.file=/tmp/nacos_sd_dev.json
ls /tmp/nacos_sd_dev.json
```

---- 
## Generated json format

generated json should be follow prometheus `file_sd_config` format like below:

```json
[
  {
    "targets": [
      "172.17.0.6:8000"
    ],
    "labels": {
      "__meta_gRPC_port": "9000",
      "__meta_http_port": "8000",
      "__meta_kind": "http",
      "__meta_nacos_group": "DEFAULT_GROUP",
      "__meta_nacos_namespace": "6440ac2f-470c-42f4-a845-d6fc7186edbc",
      "__meta_version": "v1.2.1-27-ge9d8be4",
      "__metrics_path__": "/actuator/prometheus",
      "job": "DEFAULT_GROUP@@micro-fulfillment.http"
    }
  },
  {
    "targets": [
      "172.31.16.170:3100"
    ],
    "labels": {
      "__meta_nacos_group": "DEFAULT_GROUP",
      "__meta_nacos_namespace": "6440ac2f-470c-42f4-a845-d6fc7186edbc",
      "__meta_preserved_register_source": "SPRING_CLOUD",
      "__metrics_path__": "/actuator/prometheus",
      "job": "DEFAULT_GROUP@@im-auth"
    }
  }
]
```

## about prometheus metric path
```
we set __metrics_path__ to "/actuator/prometheus" by default.
but if you set metadata with key 'context_path' in your application metadata like below , we will rewrite it to "content_path/actuator/prometheus"
```

```yaml
spring:
  cloud:
    nacos:
      discovery:
        server-addr: 192.168.1.1:8848
        namespace: dev
        metadata:
          context_path: ${server.servlet.context-path:/}
```



## Example prometheus settings

The part of your `prometheus.yml` is probably as follows.

```yaml
  scrape_configs:
      - job_name: 'nacos-discorvery'
        file_sd_configs:
        - files:
          - /apps/prometheus/conf/nacos_sd_dev.json
          - /apps/prometheus/conf/nacos_sd_test.json
          refresh_interval: 1m
    
        relabel_configs:
        - regex: 'preserved_register_source'
          action: labeldrop
```
