require 'spec_helper'

describe 'nrpe_custom_check' do
  let(:title) { 'example-check' }
  let(:pre_condition) { 'include base::nrpe' }

  context 'ensuring present, does require sudo' do
    let(:params) do
      {
        :plugin_args => '--flag example-arg',
        :requires_sudo => true,
        :content => 'some_content'
      }
    end
    it { is_expected.to contain_nrpe_custom_check__plugin('example-check').with(
      :ensure => 'present',
      :content => 'some_content'
    ) }
    it { is_expected.to contain_nrpe_custom_check__plugin_config('example-check').with(
      :ensure => 'present',
      :plugin_args => '--flag example-arg',
      :requires_sudo => true
    ) }
  end

  context 'ensuring absent' do
    let(:params) do
      {
        :ensure => 'absent',
        :content     => 'some_content'
      }
    end
    it { is_expected.to contain_nrpe_custom_check__plugin('example-check').with(
      :ensure => 'absent',
      :content => 'some_content'
    ) }
    it { is_expected.to contain_nrpe_custom_check__plugin_config('example-check').with(
      :ensure => 'absent',
      :plugin_args => '',
      :requires_sudo => false
    ) }
  end
end
