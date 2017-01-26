name             'tileserver'
maintainer       'mapzen'
maintainer_email 'rob@mapzen.com'
license          'GPL v3'
description      'Installs/Configures tileserver'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.5.0'

recipe 'tileserver', 'Mapzen Tileserver'

%w(
  apt
  git
  gunicorn
  python
  runit
  user
).each do |dep|
  depends dep
end

%w(ubuntu).each do |os|
  supports os
end
