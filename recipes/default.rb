apt_repository "datastax" do
  uri          "http://debian.datastax.com/community"
  distribution "stable"
  components   ["main"]
  key          "http://debian.datastax.com/debian/repo_key"
  action :add
end

package "libssl0.9.8" do
  action :install
end

package "opscenter-free" do
  action :install
  options("--force-yes")
end

# inform warbler of the env to use when building
template "#{node.opscenter.root}/opscenterd.conf" do
  owner 'root'
  group 'root'
  mode "644"
  source "opscenterd.conf"
end

template "#{node.opscenter.root}/.passwd" do
  owner 'root'
  group 'root'
  mode "644"
  source "passwd.erb"
end


service "opscenterd" do
  action :restart
end
