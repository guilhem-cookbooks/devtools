default['devtool']['user'] = 'vagrant'
default['devtool']['group'] = 'vagrant'
default['devtool']['home'] = '/home/vagrant'

automatic['rbenv']['root_path'] = node['devtool']['home'] + '/.rbenv/'
