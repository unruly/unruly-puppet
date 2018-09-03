require 'spec_helper'

describe 'base::yum::repos::artifactory' do

  it { is_expected.to compile }

  describe('ensure artifactory repo') do

    it { is_expected.to contain_yumrepo('UnrulyArtifactory').with(
        :baseurl  => 'https://foo:bar@url.com',
        :gpgcheck => 0,
        :descr    => 'Unruly specific packages hosted on Artifactory'
        )
      .with_ensure('present')
    }
  end

  describe('ensure artifactory repo is absent') do

    let(:params) {{ :ensure => 'absent' }}

    it { is_expected.to contain_yumrepo('UnrulyArtifactory')
         .with()
         .with_ensure('absent')
    }
  end

end
