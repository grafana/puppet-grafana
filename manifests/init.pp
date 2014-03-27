class grafana(
  $version = '1.5.2',
  $port    = 80,
  ) {

  Exec {
    path => [ '/usr/bin', '/bin' ],
  }

  exec { "${module_name} - download and extract release":
    command => "curl -L https://github.com/torkelo/grafana/releases/download/v${version}/grafana-${version}.tar.gz | tar xzf - -C /opt",
    creates => "/opt/grafana-${version}",
  } ->

  file { '/etc/nginx/sites-available/grafana':
    content => template('grafana/etc/nginx/sites-available/grafana.erb'),
  } ->

  file { '/etc/nginx/sites-enabled/grafana':
    ensure => link,
    target => '/etc/nginx/sites-available/grafana',
    notify => Service['nginx'],
  }

}
