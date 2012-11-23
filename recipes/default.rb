include_recipe "rsync"

package "debootstrap" do
  action :install
end
