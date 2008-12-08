require File.join(File.dirname(__FILE__), 'spec_helper')
require 'future'

class TimeTraveller
  include Future
end

describe Future, '#future' do
  it 'should return the return value of the block' do
    tt = TimeTraveller.new
    f1 = tt.future { 10 }
    f2 = tt.future { 20 }
    f3 = tt.future { 30 }
    (f3 + f2 + f1).should == 60
  end

  it 'should execute futures in parallel' do
    tt = TimeTraveller.new
    now = Time.now
    f1 = tt.future { sleep 0.2; 10 }
    f2 = tt.future { sleep 0.1; 20 }
    f3 = tt.future { 30 }
    f3+f2+f1
    diff = Time.now - now
    diff.should < 0.3
    diff.should > 0.1
  end
end
