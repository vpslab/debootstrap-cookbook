require 'digest/md5'

action :create do
  arch   = new_resource.arch   || node['debootstrap']['arch']
  suite  = new_resource.suite  || node['debootstrap']['suite']
  mirror = new_resource.mirror || node['debootstrap']['mirror']
  user   = new_resource.user
  group  = new_resource.group
  extra_packages = new_resource.extra_packages || node['debootstrap']['include']

  unless new_resource.cache
    debootstrap(new_resource.destination_path, suite, arch, extra_packages, mirror, user, group)
    update_bootstrapped_system(new_resource.destination_path)
  else
    tmp_dir = template_dir(new_resource.cache_dir, suite, arch, extra_packages)
    debootstrap(tmp_dir, suite, arch, extra_packages, mirror, user, group) unless ::File.exist? tmp_dir
    update_bootstrapped_system(tmp_dir)
    copy_template(tmp_dir, new_resource.destination_path)
  end

  new_resource.updated_by_last_action(true)
end

def ubuntu_suites
  %w(raring quantal precise oneiric natty maverick lucid karmic jaunty intrepid hardy)
end

def debian_suites
  %w(unstable testing stable wheezy squeeze lenny etch)
end

def template_dir(cache_root, suite, arch, extra_packages)
  template_name = ::Digest::MD5.hexdigest [suite, arch, extra_packages.sort].join
  ::File.join(cache_root, template_name)
end

def update_bootstrapped_system(bootstrap_dir)
  execute "chroot #{bootstrap_dir} apt-get update"
  execute "chroot #{bootstrap_dir} apt-get dist-upgrade -y"
end

def debootstrap(bootstrap_dir, suite, arch, extra_packages, mirror, user, group)
  base_cmd = case suite
             when *ubuntu_suites
               'debootstrap --verbose --components=main,universe'
             when *debian_suites
               'debootstrap --verbose --variant=minbase'
             end
  base_cmd << %( --include #{extra_packages.join(",")}) unless extra_packages.empty?

  execute "debootstrap #{bootstrap_dir}" do
    command "#{base_cmd} --arch #{arch} #{suite} #{bootstrap_dir} #{mirror}"
    user user
    group group
  end
end

def copy_template(src_dir, dst_dir)
  execute "copy cached template to #{dst_dir}" do
    command "rsync -a #{src_dir}/ #{dst_dir}/"
  end
end
