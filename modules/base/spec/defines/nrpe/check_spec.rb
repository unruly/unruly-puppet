require 'spec_helper'

describe 'base::nrpe::check' do
  let(:title) { 'some-script' }
  let(:params) {{ :content => 'some-content' }}
  let(:pre_condition) { ['include base::nrpe'] }

  it { is_expected.to compile }

  it { is_expected.to contain_file('/usr/lib64/nagios/plugins/some-script')
      .with(
          :ensure => 'present',
          :mode   => '0755',
      )
      .with_content('some-content')
  }

  it { is_expected.to contain_file('/etc/nrpe.d/some-script.cfg')
      .with(
          :ensure => 'present',
          :mode   => '0644',
          )
      .with_content('command[some-script]=/usr/lib64/nagios/plugins/some-script')
      .that_notifies('Service[nrpe]')
  }

  describe 'passing in a script file with a file extension' do
      let(:params) {{
          :script => 'some-script.py',
          :content => 'some-content'
      }}

      it { is_expected.to contain_file('/usr/lib64/nagios/plugins/some-script.py')
          .with(
              :ensure => 'present',
              :mode   => '0755',
              )
          .with_content('some-content')
      }

      it { is_expected.to contain_file('/etc/nrpe.d/some-script.cfg')
          .with(
              :ensure => 'present',
              :mode   => '0644',
              )
          .with_content('command[some-script]=/usr/lib64/nagios/plugins/some-script.py')
          .that_notifies('Service[nrpe]')
      }
  end

end
