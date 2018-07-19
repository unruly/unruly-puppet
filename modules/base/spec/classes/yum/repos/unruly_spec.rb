require 'spec_helper'

describe 'base::yum::repos::unruly' do

      it { is_expected.to compile }

      describe('ensure yum repo') do
        it { is_expected.to contain_yumrepo('unruly').with(
            :name     => 'unruly',
            :descr    => 'new Unruly-wide repo',
            :baseurl  => 'http://yum-unruly-baseurl.com',
            :gpgcheck => 0,
            :priority => 'absent',
            :metadata_expire => '5m',
          )
          .with_ensure('present')
        }
      end

      describe('remove yum repo') do
        let(:params) {{ :ensure => 'absent' }}

        it { is_expected.to contain_yumrepo('unruly').with(
          )
          .with_ensure('absent')
        }
      end

end
