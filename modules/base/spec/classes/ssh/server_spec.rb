require 'spec_helper'

describe 'base::ssh::server' do
  it { is_expected.to compile }

  it { is_expected.to contain_service('sshd').with_ensure('running').that_subscribes_to('File[/etc/ssh/sshd_config]') }

  it { is_expected.to contain_class('base::ssh::server::config') }
end
