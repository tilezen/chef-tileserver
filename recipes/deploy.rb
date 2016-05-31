include_recipe 'runit'

file "#{node[:tileserver][:cfg_path]}/pip-requirements.txt" do
  content node[:tileserver][:pip_requirements].join("\n")
end

bash 'install tileserver pip requirements' do
  code "pip install -U -r #{node[:tileserver][:cfg_path]}/pip-requirements.txt"
  notifies :restart, 'runit_service[tileserver]', :delayed
end

git node[:tileserver][:vector_datasource][:path] do
  action :sync
  repository node[:tileserver][:vector_datasource][:repository]
  revision node[:tileserver][:revision][:vector_datasource]
  notifies :restart, 'runit_service[tileserver]', :delayed
  notifies :run, 'bash[vectordatasource_install]', :immediately
end

bash 'vectordatasource_install' do
  cwd node[:tileserver][:vector_datasource][:path]
  code 'python setup.py install'
  action :nothing
end

template "#{node[:tileserver][:cfg_path]}/tileserver.yaml" do
  source 'tileserver.yaml.erb'
  notifies :restart, 'runit_service[tileserver]', :delayed
end

runit_service 'tileserver' do
  action [:enable]
  log true
  default_logger true
  sv_timeout node[:tileserver][:runit][:svwait]
end
