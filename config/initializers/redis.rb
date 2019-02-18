$redis = Redis::Namespace.new('weather',redis: Redis.new)

inicial_data = [{name: "Santiago (CL)",latitude: "-33.447487",longitude: "-70.673676"},{name: "Zurich (CH)",latitude: "47.451542",longitude: "8.564572"},{name: "Auckland (NZ)",latitude: "-36.848461",longitude: "174.763336"},{name: "Sydney (AU)",latitude: "-33.865143",longitude: "151.209900"},{name: "Londres (UK)",latitude:"51.50853",longitude: "-0.12574"},{name: "Georgia (US)",latitude: "33.247875",longitude: "-83.441162"}]

$redis.set("data", (Marshal.dump(inicial_data)))