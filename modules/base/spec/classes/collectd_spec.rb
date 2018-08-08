require 'spec_helper'

describe 'base::collectd' do

  let(:pre_condition) { 'include base::yum::repos::epel' }

  it { is_expected.to compile }

  it { is_expected.to contain_package('collectd')
        .with_ensure('some-version')
        .that_requires('Class[base::yum::repos::epel]')
  }

  it { is_expected.to contain_service('collectd')
        .with_ensure('running')
        .with_enable(true)
        .that_requires('Package[collectd]')
        .that_subscribes_to('File[/etc/collectd.conf]')
  }

  it { is_expected.to contain_file('/etc/collectd.d/')
        .with(
            :owner  => 'root',
            :group  => 'root',
            :mode   => '0755',
        )
        .with_ensure('directory')
  }

  it { is_expected.to contain_file('/etc/collectd.conf')
        .with(
            :owner  => 'root',
            :group  => 'root',
            :mode   => '0644'
        )
  }

  it {
    is_expected_to_have_plugins('/etc/collectd.conf',['\"logfile\"'])
    is_expected.to  contain_file('/etc/collectd.conf')
        .with_content(/^Include "\/etc\/collectd.d\/\*.conf"$/)
  }

  it { is_expected.to  contain_file('/etc/collectd.d/base.conf')
        .with(
            :owner  => 'root',
            :group  => 'root',
            :mode   => '0644'
        )
        .that_requires('File[/etc/collectd.d]')
        .that_notifies('Service[collectd]')

  }

  it {
    base_plugins = %w(contextswitch cpu cpufreq df disk entropy interface irq load memory processes protocols swap table uptime users)
    is_expected_to_have_plugins('/etc/collectd.d/base.conf', base_plugins)
  }

  it { is_expected.to  contain_file('/etc/collectd.d/graphite.conf')
        .with(
            :owner  => 'root',
            :group  => 'root',
            :mode   => '0644'
        )
        .that_requires('File[/etc/collectd.d]')
        .that_notifies('Service[collectd]')

  }

  it {
    is_expected_to_have_plugins('/etc/collectd.d/graphite.conf', %w(write_graphite))
    is_expected.to  contain_file('/etc/collectd.d/graphite.conf')
        .with_content(/\s+Host "some-host"$/)
        .with_content(/\s+Port "1337"$/)
    is_expected_to_have_config('/etc/collectd.d/graphite.conf', 'write_graphite')
  }

  it { is_expected.to  contain_file('/etc/collectd.d/unixsock.conf')
        .with(
            :owner  => 'root',
            :group  => 'root',
            :mode   => '0644'
        )
        .that_requires('File[/etc/collectd.d]')
        .that_notifies('Service[collectd]')
  }

  it {
    is_expected_to_have_plugins('/etc/collectd.d/unixsock.conf', %w(unixsock))
    is_expected_to_have_config('/etc/collectd.d/unixsock.conf', 'unixsock')
  }

  it { is_expected.to  contain_file('/var/run/collectd-unixsock')
        .with(
            :target => 'collectd.sock'
        )
        .with_ensure('link')
  }

end

def is_expected_to_have_plugins(file, plugins)
  plugins.each do |plugin|
    is_expected.to contain_file(file).with_content(/^LoadPlugin #{plugin}$/)
  end
end

def is_expected_to_have_config(file, config)
    is_expected.to contain_file(file)
           .with_content(/^<Plugin #{config}>$/)
           .with_content(/^<\/Plugin>$/)
end