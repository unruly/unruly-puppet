require 'spec_helper'

describe 'base::crond' do

  it {
    is_expected.to contain_service('crond').with(
        :ensure => 'running',
        :enable => 'true',
    )
  }
end
