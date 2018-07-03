require 'spec_helper'

describe 'base::ssh::server::config' do
  it { is_expected.to contain_file('/etc/ssh/sshd_config').with({
    :mode   => '0640',
    :owner  => 'root',
    :group  => 'root',
  })}

  it { is_expected.to contain('Protocol 2')}
  it { is_expected.to contain('PasswordAuthentication no')}
  it { is_expected.to contain('PermitRootLogin no')}
end

def contain(configuration)
  contain_file('/etc/ssh/sshd_config').with_content(/^#{configuration}$/)
end