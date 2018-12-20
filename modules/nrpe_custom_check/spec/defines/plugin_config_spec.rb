require 'spec_helper'

describe 'nrpe_custom_check::plugin_config' do
  let(:pre_condition) { 'include base::nrpe' }
  let(:title) { 'plugin' }

  context 'has no command args, does not require sudo' do
    let(:params) {
      {
          :requires_sudo => false,
          :path_to_plugin => '/some_path/plugin.sh',
      }
    }

    it { is_expected.to contain_file('/some_path/unruly/plugin.cfg')
      .with(
          :ensure => 'present',
          :group => 'root',
          :owner => 'root',
          :mode  => '0644'
      )
      .that_notifies('Service[nrpe]')
      .with_content("command[plugin]=/some_path/plugin.sh \n")
    }
  end

  context 'has command args, does not require sudo' do
    let(:params) {
      {
        :requires_sudo => false,
        :path_to_plugin => '/some_path/plugin.sh',
        :plugin_args => '--flag example-arg'
      }
    }

    it { is_expected.to contain_file('/some_path/unruly/plugin.cfg')
      .with(
        :ensure => 'present',
        :group => 'root',
        :owner => 'root',
        :mode  => '0644'
      )
      .that_notifies('Service[nrpe]')
      .with_content("command[plugin]=/some_path/plugin.sh --flag example-arg\n")
    }

    it { is_expected.to contain_nrpe_custom_check__sudo_config('plugin').with(
        :path_to_plugin => '/some_path/plugin.sh',
        :ensure       => 'absent'
    ) }
  end

  context 'no command args, requires sudo' do
    let(:params) {
      {
        :requires_sudo => true,
        :path_to_plugin => '/some_path/plugin.sh',
      }
    }

    it { is_expected.to contain_file('/some_path/unruly/plugin.cfg')
      .with(
        :ensure => 'present',
        :group => 'root',
        :owner => 'root',
        :mode  => '0644'
      )
      .that_notifies('Service[nrpe]')
      .with_content("command[plugin]=/usr/bin/sudo /some_path/plugin.sh \n")
    }

    it { is_expected.to contain_nrpe_custom_check__sudo_config('plugin').with(
        :path_to_plugin => '/some_path/plugin.sh',
        :ensure       => 'present'
    ) }
  end

  context 'ensure absent' do
    let(:params) {
      {
          :ensure => 'absent',
          :requires_sudo => true,
          :path_to_plugin => '/some_path/plugin.sh',
      }
    }

    it { is_expected.to contain_file('/some_path/unruly/plugin.cfg')
      .with(
          :ensure => 'absent'
      )
    }

    it { is_expected.to contain_nrpe_custom_check__sudo_config('plugin').with(
        :path_to_plugin => '/some_path/plugin.sh',
        :ensure       => 'absent'
    ) }
  end
end
