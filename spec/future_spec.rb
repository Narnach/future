require File.join(File.dirname(__FILE__), 'spec_helper')
require 'future'

describe Future, '.new' do
  it 'should return the return value of the block' do
    f1 = Future.new { 10 }
    f2 = Future.new { 20 }
    f3 = Future.new { 30 }
    (f3 + f2 + f1).should == 60
  end

  it 'should execute futures in parallel' do
    now = Time.now
    f1 = Future.new { sleep 0.2; 10 }
    f2 = Future.new { sleep 0.1; 20 }
    f3 = Future.new { 30 }
    f3+f2+f1
    diff = Time.now - now
    diff.should < 0.3
    diff.should > 0.1
  end

  it 'should have its own scope' do
    now = Time.now
    f1 = Future.new { now }
    f1.should_not == now
  end

  it 'should be able to pass variables to scope of the future' do
    now = Time.now
    f1 = Future.new(now) { |time| time + 10 }
    f1.should == now + 10
  end
end
