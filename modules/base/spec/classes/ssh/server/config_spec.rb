require 'spec_helper'

describe 'base::ssh::server::config' do
  it { is_expected.to contain_file('/etc/ssh/sshd_config').with({
    :mode   => '0640',
    :owner  => 'root',
    :group  => 'root',
  })}
end