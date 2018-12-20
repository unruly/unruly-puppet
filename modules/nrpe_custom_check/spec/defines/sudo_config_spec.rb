require 'spec_helper'

describe 'nrpe_custom_check::sudo_config' do
  let(:title) { 'plugin' }

  context 'requires sudo' do
    let(:params) do
      {
        :path_to_plugin => 'path_to_plugin',
        :ensure => 'present'
      }
    end
    it { is_expected.to contain_file('/etc/sudoers.d/unruly_nrpe_plugin')
      .with(
          :ensure => 'present',
          :group => 'root',
          :owner => 'root',
          :mode  => '0440'
      ).with_content("Defaults:some_user !requiretty\nsome_user ALL = NOPASSWD: path_to_plugin\n")
    }
  end

  context 'does not require sudo' do
    let(:params) do
      {
        :path_to_plugin => 'path_to_plugin',
        :ensure => 'absent'
      }
    end
    it { is_expected.to contain_file('/etc/sudoers.d/unruly_nrpe_plugin')
      .with(
          :ensure => 'absent',
          :group => 'root',
          :owner => 'root',
          :mode  => '0440'
      ).with_content("Defaults:some_user !requiretty\nsome_user ALL = NOPASSWD: path_to_plugin\n")
    }
  end
end
