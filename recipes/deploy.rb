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
# python-dateutil needs to be installed first as a workaround for edtf
# otherwise edtf installation fails
python_pip "-U #{node[:tileserver][:pip_requirements_dateutil]}"

file "#{node[:tileserver][:cfg_path]}/pip-requirements.txt" do
  content node[:tileserver][:pip_requirements].join("\n")
end

bash 'install tileserver pip requirements' do
  code "pip install -U -r #{node[:tileserver][:cfg_path]}/pip-requirements.txt"
  notifies :restart, 'runit_service[tileserver]', :delayed
end
