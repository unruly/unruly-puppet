require 'spec_helper'

describe 'base::nrpe::plugins' do

  let(:pre_condition) { 'include base::nrpe' }

  it { is_expected.to compile }

  it { is_expected.to contain_package('nagios-plugins-disk').with_ensure('some-plugins-version') }
  it { is_expected.to contain_package('nagios-plugins-procs').with_ensure('some-plugins-version') }
  it { is_expected.to contain_package('nagios-plugins-load').with_ensure('some-plugins-version') }
  it { is_expected.to contain_package('nagios-plugins-ntp').with_ensure('some-plugins-version') }

  it {
    is_expected.to contain_file('/etc/nrpe.d/base-plugins.cfg').with(
      :owner => 'root',
      :group => 'root',
      :mode  => '0644'
    )
    .that_notifies('Service[nrpe]')
    .that_requires('File[/etc/nrpe.d/]')
    .that_requires('Package[nagios-plugins-disk]')
    .that_requires('Package[nagios-plugins-load]')
    .that_requires('Package[nagios-plugins-procs]')
    .that_requires('Package[nagios-plugins-ntp]')
    .with_content(/^command\[check_disk.*$/)
    .with_content(/^command\[check_load.*$/)
    .with_content(/^command\[check_procs.*$/)
    .with_content(/^command\[check_ntp.*$/)
  }

end
