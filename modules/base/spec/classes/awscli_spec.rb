require 'spec_helper'

describe 'base::awscli' do

  it {
      is_expected.to contain_file('/usr/local/bin/aws').with(
          :ensure => 'link',
          :target => '/bin/aws',
      ).that_requires('Package[awscli]')
    }

  it {
    is_expected.to contain_package('awscli').with(
        :provider => 'pip',
        :ensure => 'present',
    )
  }
end



