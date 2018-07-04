require 'spec_helper'

describe 'base::ntp' do
  it { is_expected.to compile }

  it { is_expected.to contain_package('ntp').with_ensure('installed') }

  it { is_expected.to contain_service('ntpd').with_ensure('running').with_enable('true') }
end
