# This repo contains a Code for Packer to build a Bionic64 based vagrant box with NodeJS and Ember installed.

## Requirments:

1.  Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2.  Install [Vagrant](https://www.vagrantup.com). For more information, visit [Vagrant Documentation](https://docs.vagrantup.com/v2/)
3.  Install [Packer](http://www.packer.io)

## How to use it
- Clone the repo
```
git clone git@github.com:chavo1/packer-vagran-ember.git
cd packer-vagran-ember/ember-box
```
- To build vagrant box use below command:
```
packer build bionic64-ember.json
```
To test you will need Kitchen:

For the test you will need Kitchen it is a RubyGem so please find how to install and setup Test Kitchen for developing infrastructure code, check out the [Getting Started Guide](http://kitchen.ci/docs/getting-started/).

A following [gems](https://guides.rubygems.org/what-is-a-gem/) should be installed:

```
gem install  kitchen-vagrant
gem install  kitchen-inspec
```
Than simply execute a following commands:

```
kitchen converge
kitchen verify
kitchen destroy
```
- The output should be as follow:
```
  Command: `lsb_release -c`
     ✔  stdout should include "bionic"
  debian
     ✔  should eq "debian"
  18.04
     ✔  should eq "18.04"
  Command: `ember`
     ✔  should exist
  Command: `ember -v`
     ✔  stdout should include "3.11.0"
  Command: `node`
     ✔  should exist
  Command: `node -v`
     ✔  stdout should include "12.7.0"

Test Summary: 7 successful, 0 failures, 0 skipped
       Finished verifying <default-vbox-bionic64> (0m1.00s).
-----> Kitchen is finished. (1m14.35s)
```


