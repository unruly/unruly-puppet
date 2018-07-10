require 'spec_helper'

describe 'base::ssh::server::config' do
  it { is_expected.to contain_file('/etc/ssh/sshd_config').with({
    :mode   => '0640',
    :owner  => 'root',
    :group  => 'root',
  })}

  it { is_expected.to be_configured_with('Protocol 2')}
  it { is_expected.to be_configured_with('PasswordAuthentication no')}
  it { is_expected.to be_configured_with('PermitRootLogin no')}
end

def be_configured_with(configuration)
  contain_file('/etc/ssh/sshd_config').with_content(/^#{configuration}$/)
end