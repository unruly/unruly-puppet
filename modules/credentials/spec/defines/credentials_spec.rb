require 'spec_helper'

describe 'credentials' do
  let(:title) { 'developer' }

  let(:params) do
    {
      :system => 'artifactory',
      :config =>
        {
          :example_username => 'the_username',
          :example_password => 'the_password',
        }
    }

  end

  it { is_expected.to compile }

  it {
    should contain_file('/etc/credentials')
     .with(
       :ensure => 'directory',
       :owner  => 'root',
       :group  => 'root',
       :mode   => '0755'
     )
  }

  it {
    should contain_file("/etc/credentials/#{params[:system]}")
      .with(
        :ensure => 'directory',
        :owner  => 'root',
        :group  => 'root',
        :mode   => '0755'
      )
      .that_requires('File[/etc/credentials]')
  }

  it {
    should contain_file("/etc/credentials/#{params[:system]}/#{title}")
      .with(
        :ensure => 'directory',
        :owner  => 'root',
        :group  => 'root',
        :mode   => '0755'
      )
      .that_requires("File[/etc/credentials/#{params[:system]}]")
  }

  describe 'Credential files' do

    it {
      should contain_file("/etc/credentials/#{params[:system]}/#{title}/credentials.sh")
      .with(
        :ensure  => 'present',
        :owner   => 'root',
        :group   => 'root',
        :mode    => '0444',
        :content => "artifactory_developer_example_username=the_username\nartifactory_developer_example_password=the_password\n",
      )
      .that_requires("File[/etc/credentials/#{params[:system]}/#{title}]")
    }

    it {
      should contain_file("/etc/credentials/#{params[:system]}/#{title}/credentials.properties")
        .with(
          :ensure  => 'present',
          :owner   => 'root',
          :group   => 'root',
          :mode    => '0444',
          :content => "artifactory_developer_example_username=the_username\nartifactory_developer_example_password=the_password\n",
          )
        .that_requires("File[/etc/credentials/#{params[:system]}/#{title}]")
    }

    it {
      should contain_file("/etc/credentials/#{params[:system]}/#{title}/credentials.json")
         .with(
             :ensure  => 'present',
             :owner   => 'root',
             :group   => 'root',
             :mode    => '0444',
             :content => '{"artifactory_developer_example_username":"the_username","artifactory_developer_example_password":"the_password"}',
             )
         .that_requires("File[/etc/credentials/#{params[:system]}/#{title}]")
    }

  end

end
