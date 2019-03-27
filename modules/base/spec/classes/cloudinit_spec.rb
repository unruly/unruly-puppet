require 'spec_helper'

describe 'base::cloudinit' do

  let(:pre_condition) { 'include base::cloudinit' }

  it { is_expected.to compile }

  it { is_expected.to  contain_file('/etc/cloud/cloud-init.disabled')
                           .with(
                               :owner  => 'root',
                               :group  => 'root',
                               :mode   => '0644'
                           )
  }
end