require 'spec_helper'

describe 'nova::vncproxy' do

  let :pre_condition do
    'include nova'
  end

    context 'with default parameters' do

      describe 'on debian platforms' do
        let :facts do
          @default_facts.merge({ :osfamily => 'Debian' })
      end

      it { is_expected.to contain_nova_config('vnc/novncproxy_host').with(:value => '0.0.0.0') }
      it { is_expected.to contain_nova_config('vnc/novncproxy_port').with(:value => '6080') }

      it { is_expected.to contain_package('nova-vncproxy').with(
        :name   => 'nova-novncproxy',
        :ensure => 'present'
      ) }
      it { is_expected.to contain_service('nova-vncproxy').with(
        :name      => 'nova-novncproxy',
        :hasstatus => true,
        :ensure    => 'running'
      )}

      describe 'with manage_service as false' do
        let :params do
          { :enabled        => true,
            :manage_service => false
          }
        end
        it { is_expected.to contain_service('nova-vncproxy').without_ensure }
      end

      describe 'with package version' do
        let :params do
          {:ensure_package => '2012.1-2'}
        end
        it { is_expected.to contain_package('nova-vncproxy').with(
          'ensure' => '2012.1-2'
        )}
      end
    end
  end

  describe 'on debian OS' do
      let :facts do
        @default_facts.merge({
          :osfamily                  => 'Debian',
          :operatingsystem           => 'Debian',
          :operatingsystemmajrelease => '9',
          :os_package_type           => 'debian'
        })
      end
      it { is_expected.to contain_package('nova-vncproxy').with(
        :name   => "nova-consoleproxy",
        :ensure => 'present'
      )}
      it { is_expected.to contain_service('nova-vncproxy').with(
        :name      => 'nova-novncproxy',
        :hasstatus => true,
        :ensure    => 'running'
      )}
  end

  describe 'on Ubuntu OS with Debian packages' do
      let :facts do
        @default_facts.merge({
          :osfamily        => 'Debian',
          :operatingsystem => 'Ubuntu',
          :os_package_type => 'debian'
        })
      end
      it { is_expected.to contain_package('nova-vncproxy').with(
        :name   => "nova-consoleproxy",
        :ensure => 'present'
      )}
      it { is_expected.to contain_service('nova-vncproxy').with(
        :name      => 'nova-novncproxy',
        :hasstatus => true,
        :ensure    => 'running'
      )}
  end

  describe 'on Redhatish platforms' do

    let :facts do
      @default_facts.merge({ :osfamily => 'Redhat' })
    end

    it { is_expected.to compile.with_all_deps }

  end

end
