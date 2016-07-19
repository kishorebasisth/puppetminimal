node /^\w+\d{0,4}-www-[1-9][0-9][1-9]\.[a-z.\-]+$/ {
  class { 'tomcat':
    install_from_source => false,
  }

  class { 'epel': }->
  tomcat::instance{ 'default':
    package_name  => 'tomcat',
  }->

  tomcat::service { 'default':
    use_jsvc     => false,
    use_init     => true,
    service_name => 'tomcat',
}
  tomcat::war { 'sample.war':
    catalina_base => '/usr/share/tomcat',
    war_source => 'https://tomcat.apache.org/tomcat-6.0-doc/appdev/sample/sample.war',
  }

}

node /^\w+\d{0,4}-staticcontent-[1-9][0-9][1-9]\.[a-z.\-]+$/ {
  class { 'nginx': }
}


