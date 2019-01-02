require 'spec_helper'

describe 'nrpe_custom_check::plugin' do
  let(:title) { 'plugin.sh' }

  let(:params) do
    {
      :content => 'some_content'
    }
  end

  let(:pre_condition) { 'include base::nrpe' }

  it { is_expected.to compile }
  it { is_expected.to contain_file('/some_path/plugin.sh')
    .with(
      :ensure => 'present',
      :group => 'root',
      :owner => 'root',
      :mode  => '0755'
    )
    .that_requires('Class[base::nrpe]')
    .with_content('some_content')
  }
end
