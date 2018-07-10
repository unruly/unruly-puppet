require 'spec_helper'

describe 'base::collectd' do
  it { is_expected.to compile }

  it { is_expected.to contain_package('collectd')
        .with_ensure('some-version')
  }

  it { is_expected.to contain_service('collectd')
        .with_ensure('running')
        .with_enable(true)
        .that_requires('Package[collectd]')
  }

  it { is_expected.to contain_file('/etc/collectd.conf')
        .with(
            :owner  => 'root',
            :group  => 'root',
            :mode   => '0644')
  }

  it { is_expected.to  contain_file('/etc/collectd.conf')
        .with_content(/^LoadPlugin "logfile"$/)
        .with_content(/^Include "\/etc\/collectd.d\/\*.conf"$/)
  }

end