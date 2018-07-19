require 'spec_helper'

describe 'base::syslog_ng' do

  it { is_expected.to compile }

  it { is_expected.to contain_package('syslog-ng')
      .with(:ensure => 'some-version')
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
      .with(
          :ensure => 'running',
          :require => 'Package[syslog-ng]',
      )
  }

  it { is_expected.to contain_package('rsyslog')
      .with(:ensure => 'absent')
  }

end
