# add repository
apt_repository "datastax" do
  uri          "http://debian.datastax.com/community"
  distribution "stable"
  components   ["main"]
  key          "http://debian.datastax.com/debian/repo_key"

  action :add
end

# DataStax Server Community Edition package will not install w/o this
# one installed. MK.
package "python-cql" do
  action :install
  options("--force-yes")
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

service "opscenter" do
  supports :restart => true, :status => true
  action [:enable, :start]
end