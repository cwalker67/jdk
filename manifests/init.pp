# Class: jdk
#
# This module manages the installation of the oracle jdk for an ubuntu vm
#
# Parameters:
#
# [*version*]
# the version of the jdk to install.  By default, jdk6 will be installed
#
# Requires:
# stdlib
#
class jdk(
    $version = 'jdk6'
) {
    include jdk::params
    include apt
    
    validate_re($version, 'jdk6|jdk7')
    
    if has_key($jdk::params::java, $version) {
        $install_package_name     = $jdk::params::java[$version]['package']
        $install_java_home        = $jdk::params::java[$version]['home']
    } else {
        fail("Java distribution ${distribution} is not supported.")
    }
    
    
    anchor { 'jdk::begin:': }
    ->
    apt::ppa { "ppa:webupd8team/java": }
    ->
    exec { 'apt-get update java repo':
        command => '/usr/bin/apt-get update',
    }
    ->
    exec {
        "accept_license":
        command => "echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections && echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections",
        cwd => "/home/vagrant",
        user => "vagrant",
        path    => "/usr/bin/:/bin/",
        logoutput => true,
    }
    ->
    package { 'jdk':
        ensure => 'present',
        name => $install_package_name,
    }
    ->
    file_line {'add java_home':
        ensure => 'present',
        line => "JAVA_HOME=${install_java_home}",
        path => '/etc/environment',
    }
    ->
    anchor { 'jdk::end:': }
    
}
