require 'spec_helper'

describe 'base::collectd::config' do
  let(:title) { 'test_config.conf' }
  let(:params) {{ :content => 'some-content' }}
  let(:pre_condition) { ['include base::collectd', 'include base::yum::repos::epel'] }

  it { is_expected.to compile }

  it {
      should contain_file('/etc/collectd.d/test_config.conf')
       .with(
           :owner   => 'root',
           :group   => 'root',
           :mode    => '0644'
       )
       .that_requires('File[/etc/collectd.d]')
       .that_notifies('Service[collectd]')
       .with_content('some-content')
  }

end
