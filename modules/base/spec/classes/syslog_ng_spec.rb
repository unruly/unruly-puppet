require 'spec_helper'

describe 'base::syslog_ng' do

  let(:pre_condition) { 'include base::yum::repos::epel' }

  it { is_expected.to compile }

  it { is_expected.to contain_package('syslog-ng')
      .with_ensure('some-version')
      .that_requires('Class[base::yum::repos::epel]')
  }

  it { is_expected.to contain_file('/etc/syslog-ng/syslog-ng.conf')
      .with(
          :mode     => '0644',
          :owner    => 'root',
          :group    => 'root',
      )
      .that_requires('Package[syslog-ng]')
      .that_notifies('Service[syslog-ng]')
  }

  it { is_expected.to contain_file('/etc/syslog-ng/syslog-ng.conf')
      .with_content(/^# syslog-ng configuration file.$/)
      .with_content(/^  unix-dgram \(\"\/dev\/log\"\);$/)
  }

  it { is_expected.to contain_service('syslog-ng')
      .with_ensure('running')
      .that_requires('Package[syslog-ng]')
  }

  it { is_expected.to contain_package('rsyslog')
      .with_ensure('absent')
  }

end
