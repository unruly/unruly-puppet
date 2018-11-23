require 'spec_helper'

describe 'monitoring::nagios::nsca' do
  let(:pre_condition) { 'include monitoring::nagios' }
  let(:pre_condition) { 'include base::yum::repos::epel' }

  it { is_expected.to compile }

  it { is_expected.to contain_package('nsca').with_ensure('some-nsca-version') }

end
