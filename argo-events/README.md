# Example 01

1. `kubectl apply -n argo-events -f 01_simple_nats_sensor.yaml`
2. `kubectl apply -n argo-events -f 01_always_fail.yaml`
3. post a message to hydroge.test.workflow1: `nats pub hydrogen.test.workflow1 '{"message": "hello","tid":"x"}'`
4. post a message to hydroge.test.workflow2: `nats pub hydrogen.test.workflow2 '{"message": "hello","tid":"x"}'`

# Example 2

This example assumed you deployed example 01 first

1. `kubectl apply -n argo-events -f 02_multistep_sensor.yaml`
2. `kubectl apply -n argo-events -f 02_always_fail.yaml`
3. post a message to hydroge.test.workflow1: `nats pub hydrogen.test.workflow1 '{"message": "hello","tid":"x"}'`
4. post a message to hydroge.test.workflow1: `nats pub hydrogen.test.workflow2 '{"message": "hello","tid":"x"}'`

# Example 3

This example assumed you deployed example 02 first

1. `kubectl apply -n argo-events -f 03_multistep_sleep_sensor.yaml`
2. post a message to hydroge.test.workflow1: `nats pub hydrogen.test.workflow1 '{"message": "hello","tid":"x"}'`


# cleanup

* `argo delete --all -A`
* `k delete -f -n argo-events 02_multistep_sensor.yaml`
* `kubectl apply -n argo-events -f 02_always_fail.yaml`
