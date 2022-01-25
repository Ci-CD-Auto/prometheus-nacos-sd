# prometheus-nacos-sd

Prometheus 通过`file_sd_config`服务自动发现

----
## 安装方式

### Docker


```
docker pull houshuai0816/prometheus-nacos-sd:1.0.0
docker run -it -d -v /tmp:/tmp --name prometheus-nacos-sd houshuai0816/prometheus-nacos-sd:1.0.0 --nacos.address=192.168.1.1:8848 --nacos.namespaceId=6440ac2f-470c-42f4-a845-d6fc7186edbc --output.file=/tmp/nacos_sd_dev.json
ls /tmp/nacos_sd_dev.json
```

---- 
## 生成的json文件

生成的文件应存放在 prometheus `file_sd_config` 文件下

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

## prometheus 设置例子 

在 `prometheus.yml` 中进行修改长如下例子内容 

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

## 资料
1. [prometheus-sd](https://github.com/prometheus/prometheus/tree/main/documentation/examples/custom-sd)