require 'spec_helper'

describe 'base::selinux' do

  it { is_expected.to compile }

  it { is_expected.to contain_file('/etc/selinux/config')
      .with(
        :group => 'root',
        :owner => 'root',
        :mode  => '0644'
      )
      .with_content(/^SELINUX=permissive$/)
  }

end
