Description
===========

Manage installations of base Debian and Ubuntu systems.

Requirements
============

Ubuntu or Debian distribution.

Attributes
==========

`node['debootstrap']` - namespace to define debootstrap parameters

    :debootstrap => {
      :mirror => "http://cdn.debian.net/debian",
      :suite => "squeeze",
      :extra_packages => %w(locales openssh-server),
      :arch => "amd64"
    }

Debootstrap resource
====================

    include_recipe "debootstrap"

    debootstrap destination_path do
      arch "amd64"
      suite "wheezy"
      extra_packages %w(sudo)
      mirror "http://mirror.hetzner.de/debian/packages"
    end

Caching deboostrap templates
============================

Debootstrap process can take several minutes depending on machine and mirror used.
Simple template caching can be used to improve the process if debootstrap
is used repeateadly with the same parameteres:

    debootstrap destination_path do
      suite "precise"
      arch  "amd64"
      cache true
      cache_dir "/var/cache/debootstrap"
    end

Each cached run updates debootstrap template. Beware that template is created for
each set of `suite`, `arch` and `extra_packages` and is never purged.


License and Author
==================

Author:: Paweł Pacana (<pawel.pacana@gmail.com>)

Copyright:: 2012, VPSLab

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
