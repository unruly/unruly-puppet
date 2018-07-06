require 'spec_helper'

describe 'base::yum::repos::epel' do

  it { is_expected.to compile }

  it { is_expected.to contain_package('epel-release').with_ensure('some-version') }
end
