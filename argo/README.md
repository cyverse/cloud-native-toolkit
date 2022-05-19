# example 1, simple workflow

`argo submit 01_hello_world.yaml`

# example 2, two step no dependency

`argo submit 02_two_step.yaml`

# example 3, two step with output-input parameter passing

`argo submit 03_two_step_with_parameter_passing.yaml -p 'message="this is four words"'`

# example 4, two-step with output-input parameter passing with embedded script

`argo submit 04_two_dag_with_parameter_passing -p 'message="https://argoproj.github.io/argo-workflows/workflow-inputs/"' -p 'is_url="1"'`

`argo submit 04_two_dag_with_parameter_passing -p 'message="this should be five words"' -p 'is_url="0"`

# cleaning up
1. `argo delete --all -A`
