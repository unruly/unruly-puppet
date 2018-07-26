require 'spec_helper'

describe 'base::nrpe' do

  it { is_expected.to compile }

  it {
    is_expected.to contain_package('nrpe').with(
      :ensure => 'some-version',
    )
  }

  it {
    is_expected.to contain_service('nrpe')
      .with_ensure('running')
      .with_enable(true)
      .that_subscribes_to('File[/etc/nagios/nrpe.cfg]')
      .that_requires('Package[nrpe]')
  }

  it {
    is_expected.to contain_file('/etc/nagios/nrpe.cfg')
      .with(
          :ensure => 'present',
          :owner  => 'root',
          :group  => 'root',
          :mode   => '0644',

      )
      .that_requires('Package[nrpe]')
  }

  it {
    is_expected.to contain_file('/etc/nagios/nrpe.cfg')
      .with_content(/^allowed_hosts=bar\.nrpe\.com,foo\.nrpe\.com,127\.0\.0\.1,::1$/)
      .with_content(/^dont_blame_nrpe=1$/)
  }

  it {
    is_expected.to contain_file('/etc/nrpe.d')
      .with(
        :ensure  => 'directory',
        :owner   => 'root',
        :group   => 'root',
        :mode    => '0755',
      )
      .that_requires('Package[nrpe]')
  }

end
