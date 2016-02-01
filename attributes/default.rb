default[:tileserver][:user][:name] = 'tileserver'
default[:tileserver][:user][:enabled] = true

default[:tileserver][:cfg_path] = '/etc/tileserver'
default[:tileserver][:run_path] = '/var/run/tileserver'

default[:tileserver][:gunicorn][:enabled] = true
default[:tileserver][:gunicorn][:worker_class] = 'gevent'
default[:tileserver][:gunicorn][:worker_processes] = node[:cpu][:total] * 2 + 1
default[:tileserver][:gunicorn][:worker_timeout] = 60
# default access log format
default[:tileserver][:gunicorn][:access_log_format] = '%(h)s %(l)s %(u)s %(t)s "%(r)s" %(s)s %(b)s "%(f)s" "%(a)s"'

default[:tileserver][:runit][:svwait] = 180

default[:tileserver][:revision][:tilestache] = 'integration-1'
default[:tileserver][:revision][:tilequeue] = 'master'
default[:tileserver][:revision][:mapbox_vector_tile] = 'master'
default[:tileserver][:revision][:tileserver] = 'master'

default[:tileserver][:pip_requirements_pypi] = %w(
  argparse==1.2.1
  boto==2.33.0
  hiredis==0.1.5
  ModestMaps==1.4.6
  numpy==1.10.4
  Pillow==2.6.1
  protobuf==2.6.0
  psycopg2==2.5.4
  python-dateutil==2.4.2
  PyYAML==3.11
  redis==2.10.3
  Shapely==1.4.3
  simplejson==3.6.4
  StreetNames==0.1.5
  Werkzeug==0.9.6
  wsgiref==0.1.2
)
default[:tileserver][:pip_requirements_git] = [
  "git+https://github.com/mapzen/TileStache@#{node[:tileserver][:revision][:tilestache]}#egg=TileStache",
  "git+https://github.com/mapzen/tilequeue@#{node[:tileserver][:revision][:tilequeue]}#egg=tilequeue",
  "git+https://github.com/mapzen/mapbox-vector-tile@#{node[:tileserver][:revision][:mapbox_vector_tile]}#egg=mapbox-vector-tile",
  "git+https://github.com/mapzen/tileserver@#{node[:tileserver][:revision][:tileserver]}#egg=tileserver"
]

default[:tileserver][:postgresql][:host] = 'localhost'
default[:tileserver][:postgresql][:port] = 5432
default[:tileserver][:postgresql][:dbnames] = ['osm']
default[:tileserver][:postgresql][:user] = 'osm'
default[:tileserver][:postgresql][:password] = ''

default[:tileserver][:redis][:enabled] = false
default[:tileserver][:store][:enabled] = false
default[:tileserver][:queue][:enabled] = false

default[:tileserver][:vector_datasource][:repository] = 'https://github.com/mapzen/vector-datasource.git'
default[:tileserver][:vector_datasource][:revision] = 'dev'
default[:tileserver][:vector_datasource][:path] = "#{node[:tileserver][:cfg_path]}/vector-datasource"

default[:tileserver][:health][:enabled] = true
default[:tileserver][:health][:url] = '/_health'
