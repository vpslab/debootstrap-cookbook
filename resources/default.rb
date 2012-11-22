actions :create

def initialize(*args)
  super
  @action = :create
end

attribute :mirror, :kind_of => String
attribute :arch,   :kind_of => String
attribute :suite,  :kind_of => String
attribute :extra_packages,   :kind_of => Array
attribute :destination_path, :kind_of => String, :name_attribute => true
