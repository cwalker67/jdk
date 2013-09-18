# Class: jdk::params
#
class jdk::params {

    $java = {
        'jdk6' => {
            'package' => 'oracle-java6-installer',
            'home' => '/usr/lib/jvm/java-6-oracle'
        },
        'jdk7' => {
            'package' => 'oracle-java7-installer',
            'home' => '/usr/lib/jvm/java-7-oracle'
        }
    }
}