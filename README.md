**Status:** Archive (code is provided as-is, no updates expected)

# Distributed evolution

This is a distributed implementation of the algorithm described in [Evolution Strategies as a Scalable Alternative to Reinforcement Learning](https://arxiv.org/abs/1703.03864) (Tim Salimans, Jonathan Ho, Xi Chen, Ilya Sutskever).

The implementation here uses a master-worker architecture: at each iteration, the master broadcasts parameters to the workers, and the workers send returns back to the master. The humanoid scaling experiment in the paper was generated with an implementation similar to this one.

The code here runs on EC2, so you need an AWS account. It's resilient to worker termination, so it's safe to run the workers on spot instances.

## Instructions

### Build AMI
The humanoid experiment depends on Mujoco. Provide your own Mujoco license and binary in `scripts/dependency.sh`.

Install [Packer](https://www.packer.io/), and then build images by running (you can optionally configure `scripts/packer.json` to choose build instance or AWS regions)
```
cd scripts && packer build packer.json
```

Packer should return you a list of AMI ids, which you should place in `AMI_MAP` in `scripts/launch.py`.

### Launching
Use `scripts/launch.py` along with an experiment JSON file. An example JSON file is provided in the `configurations` directory. You must fill in all command-line arguments to `scripts/launch.py`.
