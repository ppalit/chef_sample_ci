#
# Cookbook:: org_base
# Spec:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'org_base::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates the jamie user' do
      expect(chef_run).to create_user('create user jamie')
        .with(username: 'jamie')
        .with(group: nil)
    end

    it 'doesn\'t create the hello.txt file' do
      expect(chef_run).to_not create_file('creates the hello.txt file')
    end
  end

  context 'When the user attribute is set' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '18.04') do |node|
        node.automatic['user'] = 'test'
        node.automatic['group'] = 'users'
        node.automatic['hello'] = true
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates the test user' do
      expect(chef_run).to create_user('create user test')
        .with(username: 'test')
        .with(group: 'users')
    end

    it 'creates the hello.txt file' do
      expect(chef_run).to create_file('creates the hello.txt file')
        .with(path: '~test/hello.txt')
        .with(content: 'hello test')
        .with(mode: '0600')
        .with(owner: 'test')
    end
  end
end
