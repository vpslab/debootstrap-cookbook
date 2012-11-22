action :create do
  arch   = new_resource.arch   || node['debootstrap']['arch']
  suite  = new_resource.suite  || node['debootstrap']['suite']
  mirror = new_resource.mirror || node['debootstrap']['mirror']
  extra_packages = new_resource.extra_packages || node['debootstrap']['include']

  base_cmd = case suite
             when *ubuntu_suites
               'debootstrap --verbose --components=main,universe'
             when *debian_suites
               'debootstrap --verbose --variant=minbase'
             end
  base_cmd << %( --include #{extra_packages.join(",")}) unless extra_packages.empty?

  execute "debootstrap #{new_resource.destination_path}" do
    command "#{base_cmd} --arch #{arch} #{suite} #{new_resource.destination_path} #{mirror}"
  end

  new_resource.updated_by_last_action(true)
end

def ubuntu_suites
  %w(raring quantal precise oneiric natty maverick lucid karmic jaunty intrepid hardy)
end

def debian_suites
  %w(unstable testing stable wheezy squeeze lenny etch)
end
