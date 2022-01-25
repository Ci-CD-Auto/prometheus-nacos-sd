module prometheus-nacos-sd

go 1.13

require (
	github.com/go-kit/kit v0.10.0
	github.com/nacos-group/nacos-sdk-go v1.1.0
	github.com/prometheus/common v0.10.0
	github.com/prometheus/prometheus v1.8.2-0.20200805170718-983ebb4a5133
	gopkg.in/alecthomas/kingpin.v2 v2.2.6
)

replace k8s.io/klog => github.com/simonpasquier/klog-gokit v0.1.0
