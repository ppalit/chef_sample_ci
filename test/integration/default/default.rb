describe user('test') do
  it { should exist }
  its('groups') { should eq ['everybody'] }
end

describe group('everybody') do
  it { should exist }
end

describe directory('/home/test') do
  it { should exist }
end

describe file('/home/test/hello.txt') do
  it { should exist }
  its('mode') { should cmp '0600' }
  its('owner') { should eq 'test' }
  its('content') { should eq 'hello test' }
end
