require 'spec_helper'

describe 'base::python' do
  it {
    is_expected.to contain_package('python').with(
        :ensure => 'some-version',
        )
    is_expected.to contain_package('python2-pip').with(
        :ensure => 'some-version',
        ).that_requires('Package[python]')
    is_expected.to contain_file('/usr/bin/pip-python').with(
        :ensure => 'link',
        :target => '/usr/bin/pip',
    ).that_requires('Package[python2-pip]')
  }
end
