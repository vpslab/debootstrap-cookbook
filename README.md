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
