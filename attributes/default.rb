default[:tileserver][:user][:name] = 'tileserver'
default[:tileserver][:user][:enabled] = true

default[:tileserver][:cfg_path] = '/etc/tileserver'
default[:tileserver][:log_path] = '/var/log/tileserver'
default[:tileserver][:run_path] = '/var/run/tileserver'

default[:tileserver][:gunicorn][:worker_class] = 'gevent'
default[:tileserver][:gunicorn][:worker_processes] = node[:cpu][:total] * 2 + 1
default[:tileserver][:gunicorn][:enabled] = true

default[:deploy][:tilestache][:scm][:repository] = 'https://github.com/mapzen/vector-datasource.git'
default[:deploy][:tilestache][:scm][:revision] = 'master'
default[:opsworks][:instance][:layers] = []

default[:tileserver][:runit][:svwait] = 180

default[:tileserver][:pip_requirements] = %w(
  argparse==1.2.1
  boto==2.33.0
  hiredis==0.1.5
  mapbox-vector-tile==0.0.10
  ModestMaps==1.4.6
  Pillow==2.6.1
  protobuf==2.6.0
  psycopg2==2.5.4
  python-memcached==1.53
  PyYAML==3.11
  redis==2.10.3
  Shapely==1.4.3
  simplejson==3.6.4
  StreetNames==0.1.5
  Werkzeug==0.9.6
  wsgiref==0.1.2
  git+https://github.com/mapzen/TileStache@integration-1#egg=TileStache
  git+https://github.com/mapzen/tilequeue#egg=tilequeue
  git+https://github.com/mapzen/tileserver#egg=tileserver
)

default[:tileserver][:postgresql][:host] = 'localhost'
default[:tileserver][:postgresql][:port] = 5432
default[:tileserver][:postgresql][:dbnames] = ['osm']
default[:tileserver][:postgresql][:user] = 'osm'
default[:tileserver][:postgresql][:password] = ''

default[:tileserver][:redis][:enabled] = false
default[:tileserver][:store][:enabled] = false

default[:tilestache][:cfg_path] = node[:tileserver][:cfg_path]
default[:mapzen_tilestache][:cache][:type] = 'none'
default[:mapzen_tilestache][:max_age] = 0
default[:mapzen][:postgresql][:endpoint] = 'localhost'
default[:mapzen][:secrets][:postgresql][:password][:gisuser] = 'secret'
default[:mapzen_tilestache][:query_dir_name] = "#{node[:tileserver][:cfg_path]}/osm-vector-queries"
