include_recipe 'runit'

runit_service 'tileserver' do
  action [:enable]
  log true
  default_logger true
  sv_timeout node[:tileserver][:runit][:svwait]
end

git node[:tileserver][:vector_datasource][:path] do
  action :sync
  repository node[:tileserver][:vector_datasource][:repository]
  revision node[:tileserver][:vector_datasource][:revision]
  notifies :restart, 'runit_service[tileserver]', :delayed
end

template "#{node[:tileserver][:cfg_path]}/tileserver.yaml" do
  source 'tileserver.yaml.erb'
  notifies :restart, 'runit_service[tileserver]', :delayed
end

# It might be nice to conditionally notify here, but because we can
# point to individual branches, this file would not have changed, but
# the code would have. Therefore we want to always run the pip install
# on the requirements file to ensure that we get the latest packages
# installed.
#
# note that we split the second set of git-based requirements off into
# a separate file which is installed in a separate run due to a bug in
# the setup.py of the EDTF library.
[:pip_requirements_pypi, :pip_requirements_git].each do |req|
  file "#{node[:tileserver][:cfg_path]}/#{req.to_s}.txt" do
    content node[:tileserver][req].join("\n")
  end

  bash "install tileserver #{req.inspect}" do
    code "pip install -U -r #{node[:tileserver][:cfg_path]}/#{req.to_s}.txt"
    notifies :restart, 'runit_service[tileserver]', :delayed
  end
end
