jdk
==========

Puppet module for installing an oracle jdk from apt repo ppa:webupd8team


Usage:

    include jdk
  
or

    class { 'jdk':
      version => 'jdk6',
    }
