require 'spec_helper'

describe 'dcm4chee::config::jboss', :type => :class do
  
  describe 'without defaults and server_java_path set' do
    let :pre_condition do
      "class {'dcm4chee':
         server_java_path => '/usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java',
       }"
    end

    it { is_expected.to contain_file('/opt/dcm4chee/dcm4chee-2.18.0-mysql/server/default/deploy/jboss-web.deployer/server.xml')
          .with({
            'ensure'  => 'file',
            'owner'   => 'dcm4chee',
            'group'   => 'dcm4chee',
            'mode'    => '0644',
          })
    }
    it { is_expected.to contain_file('/opt/dcm4chee/dcm4chee-2.18.0-mysql/bin/run.conf')
          .with({
            'ensure'  => 'file',
            'owner'   => 'dcm4chee',
            'group'   => 'dcm4chee',
            'mode'    => '0644',
          })
    }
 end
end

