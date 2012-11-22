default['debootstrap'] = {}
default['debootstrap']['extra_packages'] = []

case node['kernel']['machine']
when /x86_64/
  default['debootstrap']['arch'] = "amd64"
else
  default['debootstrap']['arch'] = "i386"
end

case node['platform']
when 'ubuntu'
  default['debootstrap']['suite']  = 'precise'
  default['debootstrap']['mirror'] = 'http://archive.ubuntu.com/ubuntu'
when 'debian'
  default['debootstrap']['suite']  = 'squeeze'
  default['debootstrap']['mirror'] = 'http://cdn.debian.net/debian'
end
