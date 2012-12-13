actions :create

def initialize(*args)
  super
  @action = :create
end

attribute :mirror, :kind_of => String
attribute :arch,   :kind_of => String
attribute :suite,  :kind_of => String
attribute :owner,  :kind_of => String
attribute :group,  :kind_of => String
attribute :cache,  :kind_of => TrueClass, :default => false
attribute :cache_dir,        :kind_of => String, :default => "/var/cache/debootstrap"
attribute :extra_packages,   :kind_of => Array
attribute :destination_path, :kind_of => String, :name_attribute => true
