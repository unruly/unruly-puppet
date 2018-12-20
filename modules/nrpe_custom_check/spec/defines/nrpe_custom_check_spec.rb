require 'spec_helper'

describe 'nrpe_custom_check' do
  let(:title) { 'check_example' }
  let(:pre_condition) { 'include base::nrpe' }

  context 'ensuring present, does require sudo' do
    let(:params) do
      {
        :plugin_module_path => 'module_path',
        :plugin_name => 'plugin.sh',
        :plugin_args => '--flag example-arg',
        :requires_sudo => true
      }
    end
    it { is_expected.to contain_nrpe_custom_check__plugin('plugin.sh').with(
      :ensure => 'present',
      :plugin_module_path  => 'module_path'
    ) }
    it { is_expected.to contain_nrpe_custom_check__plugin_config('check_example').with(
      :ensure => 'present',
      :plugin_args => '--flag example-arg',
      :requires_sudo => true
    ) }
  end

  context 'ensuring absent' do
    let(:params) do
      {
        :ensure => 'absent',
        :plugin_module_path => 'module_path',
        :plugin_name => 'plugin.sh',
      }
    end
    it { is_expected.to contain_nrpe_custom_check__plugin('plugin.sh').with(
      :ensure => 'absent',
      :plugin_module_path  => 'module_path'
    ) }
    it { is_expected.to contain_nrpe_custom_check__plugin_config('check_example').with(
      :ensure => 'absent',
      :plugin_args => '',
      :requires_sudo => false
    ) }
  end
end
