require 'spec_helper'

describe 'dcm4chee::staging', :type => :class do
 
  describe 'without parameters' do
    let :pre_condition do
      "class {'dcm4chee':
         server_java_path => '/usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java',
       }"
    end

    it { is_expected.to contain_class('staging') }
    it { is_expected.to contain_file('/opt/dcm4chee/staging/')
          .with({
            'ensure' => 'directory',
            'owner'  => 'dcm4chee',
            'group'  => 'dcm4chee',
          })
    }
    it { is_expected.to contain_staging__deploy('dcm4chee-2.18.0-mysql.zip')
          .with({
            'source'  => 'http://sourceforge.net/projects/dcm4che/files/dcm4chee/2.18.0/dcm4chee-2.18.0-mysql.zip/download',
            'target'  => '/opt/dcm4chee/staging/',
            'user'    => 'dcm4chee',
            'group'   => 'dcm4chee',
          })
          .that_requires('File[/opt/dcm4chee/staging/]')
    }
    it { is_expected.to contain_class('dcm4chee::staging::replace_jai_imageio_with_64bit')
          .that_requires('Staging::Deploy[dcm4chee-2.18.0-mysql.zip]')
    }
    it { is_expected.to contain_class('dcm4chee::staging::jboss')
          .that_requires('File[/opt/dcm4chee/staging/]')
    }
    it { is_expected.to contain_exec('/opt/dcm4chee/staging/dcm4chee-2.18.0-mysql/bin/install_jboss.sh')
          .that_requires('Staging::Deploy[dcm4chee-2.18.0-mysql.zip]')
          .that_requires('Class[dcm4chee::staging::jboss]')
    }
    it { is_expected.to contain_file('/opt/dcm4chee/staging/dcm4chee-2.18.0-mysql/bin/run.sh')
          .with({
            'ensure'  => 'present',
            'owner'   => 'dcm4chee',
            'source'  => '/opt/dcm4chee/staging/jboss-4.2.3.GA/bin/run.sh',
          })
          .that_requires('Exec[/opt/dcm4chee/staging/dcm4chee-2.18.0-mysql/bin/install_jboss.sh]')
    }
    it { is_expected.to contain_class('dcm4chee::staging::weasis')
         .that_requires('File[/opt/dcm4chee/staging/dcm4chee-2.18.0-mysql/bin/run.sh]')
    }
  end
  describe 'given server = false and database = true' do
    let :pre_condition do
      "class {'dcm4chee':
         server => false,
       }"
    end

    it { is_expected.to contain_class('staging') }
    it { is_expected.to contain_file('/opt/dcm4chee/staging/')
          .with({
            'ensure' => 'directory',
            'owner'  => 'dcm4chee',
            'group'  => 'dcm4chee',
          })
    }
    it { is_expected.to contain_staging__deploy('dcm4chee-2.18.0-mysql.zip')
          .with({
            'source'  => 'http://sourceforge.net/projects/dcm4che/files/dcm4chee/2.18.0/dcm4chee-2.18.0-mysql.zip/download',
            'target'  => '/opt/dcm4chee/staging/',
            'user'    => 'dcm4chee',
            'group'   => 'dcm4chee',
          })
          .that_requires('File[/opt/dcm4chee/staging/]')
    }
    it { is_expected.not_to contain_class('dcm4chee::staging::replace_jai_imageio_with_64bit') }
    it { is_expected.not_to contain_class('dcm4chee::staging::jboss') }
    it { is_expected.not_to contain_exec('/opt/dcm4chee/staging/dcm4chee-2.18.0-mysql/bin/install_jboss.sh') }
    it { is_expected.not_to contain_file('/opt/dcm4chee/staging/dcm4chee-2.18.0-mysql/bin/run.sh') }
    it { is_expected.not_to contain_class('dcm4chee::staging::weasis') }
 end
end

