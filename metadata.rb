maintainer       "VPSLab"
maintainer_email "pawel.pacana@gmail.com"
name             "debootstrap"
license          "Apache 2.0"
description      "Installs debootstrap"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.2"
depends          "rsync"

%w(ubuntu debian).each do |os|
  supports os
end
