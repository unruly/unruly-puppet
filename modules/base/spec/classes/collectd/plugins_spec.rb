require 'spec_helper'

describe 'base::collectd::plugins' do
  it { is_expected.to compile }

  it { is_expected.to contain_package('some-package').with(:ensure => 'some-version') }
end
