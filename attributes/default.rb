default[:tileserver][:user][:name] = 'tileserver'
default[:tileserver][:user][:enabled] = true

default[:tileserver][:cfg_path] = '/etc/tileserver'
default[:tileserver][:run_path] = '/var/run/tileserver'

default[:tileserver][:gunicorn][:enabled] = true
default[:tileserver][:gunicorn][:listen] = "unix:#{node[:tileserver][:run_path]}/gunicorn.socket"
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
default[:tileserver][:revision][:vector_datasource] = 'master'

default[:tileserver][:pip_requirements] = %w(
  appdirs==1.4.3
  argparse==1.2.1
  boto==2.33.0
  future==0.15.2
  hiredis==0.2.0
  Jinja2==2.8
  MarkupSafe==0.23
  ModestMaps==1.4.6
  protobuf==2.6.0
  psycopg2==2.5.4
  pyclipper==1.0.5
  pycountry==1.20
  pyproj==1.9.5.1
  python-dateutil==2.4.2
  PyYAML==3.11
  redis==2.10.5
  requests==2.10.0
  Shapely==1.4.3
  simplejson==3.6.4
  six==1.10.0
  StreetNames==0.1.5
  ujson==1.35
  Werkzeug==0.9.6
  wsgiref==0.1.2
  zope.dottedname==4.1.0
  git+https://github.com/ixc/python-edtf@aad32b8d5cd8848c50fbef92c73697a93cf182ba#edtf
)

default[:tileserver][:pip_requirements] += [
  "git+https://github.com/mapzen/mapbox-vector-tile@#{node[:tileserver][:revision][:mapbox_vector_tile]}#egg=mapbox-vector-tile",
  "git+https://github.com/mapzen/tilequeue@#{node[:tileserver][:revision][:tilequeue]}#egg=tilequeue",
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
default[:tileserver][:queue][:zoom_queue_map] = nil

default[:tileserver][:vector_datasource][:repository] = 'https://github.com/mapzen/vector-datasource.git'
default[:tileserver][:vector_datasource][:path] = "#{node[:tileserver][:cfg_path]}/vector-datasource"

default[:tileserver][:health][:enabled] = true
default[:tileserver][:health][:url] = '/_health'

default[:tileserver][:formats] = nil
default[:tileserver][:buffer] = nil

default[:tileserver][:metatile][:enabled]                      = false
default[:tileserver][:metatile][:size]                         = 1
default[:tileserver][:metatile][:store_metatile_and_originals] = false
