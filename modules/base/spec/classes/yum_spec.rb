require 'spec_helper'

describe 'base::yum' do

  let(:params) {{ :yum_pkgs => ['yum-plugin-changelog'] }}

  it { is_expected.to compile }

  it { is_expected.to contain_package('yum-plugin-changelog').with_ensure('installed') }

  it { is_expected.to contain_class('base::yum::clean') }
end
