require 'spec_helper'

describe 'base' do

  it { is_expected.to compile }

  it { is_expected.to contain_class('base::ntp') }
  it { is_expected.to contain_class('base::ssh::server') }
  it { is_expected.to contain_class('base::yum') }
  it { is_expected.to contain_class('base::yum::repos::unruly') }
  it { is_expected.to contain_class('base::yum::repos::epel') }
end
