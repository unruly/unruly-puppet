require 'spec_helper'

describe 'cron::cleanup' do
  let(:title) { 'example' }
  let(:params) do
    {
        :directory => '/some/path',
        :last_modified_threshold => '666'
    }
  end

  it { is_expected.to compile }

  it {
    is_expected
        .to contain_cron('clean_up_example')
        .with(
            {
                :command => "find /some/path -type f -mtime +666 | xargs rm -f | logger -i -t clean_up_example && find /some/path -type d -empty -delete | logger -i -t clean_up_example",
                :user     => 'root',
                :minute  => "0",
                :hour    => "*/3"
            }
        )
  }

  context 'with different params' do
    let(:title) { 'example' }
    let(:params) do
      {
          :directory => '/some/other/path',
          :last_modified_threshold => '999'
      }
    end

    it {
      is_expected
          .to contain_cron('clean_up_example')
                  .with(
                      {
                          :command => "find /some/other/path -type f -mtime +999 | xargs rm -f | logger -i -t clean_up_example && find /some/other/path -type d -empty -delete | logger -i -t clean_up_example",
                          :user     => 'root',
                          :minute  => "0",
                          :hour    => "*/3"
                      }
                  )
    }
  end
end