# Future implements the future concept from IO.
# A future is an object that you create now, but which only gets a usable
# value in the future. Think of asynchronous messaging and long-lasting method
# calls.
#
# An example:
#   f = Future.new { sleep 5; 123}
#   f * 5 # => 615
# This future will take 5 seconds to run, then 123 is returned.
# The call to f.* will block until the future has a return value.
#
# Another example:
#   f1 = Future.new { sleep 5; 10}
#   f2 = Future.new { sleep 3; 20}
#   f3 = Future.new { sleep 1; 30}
#   f3 + f2 + f1 # => 60
# Here it only takes 5 seconds to calculate the sum instead of the 9 it would take when done sequentially.
#
# Futures have their own thread and thus don't have access to scope they were created from.
# If you do require values from outside the future, pass them to the Future when creating it:
#
#   one = 1
#   two = 2
#   sum = Future.new(one, two) {|a,b| a + b} # => 3
class Future
  (instance_methods - %w[__send__ __id__ object_id]).each do |meth|
    undef_method meth
  end

  def initialize(*args, &block)
    @thread = Thread.new(*args, &block)
  end

  def method_missing(*args, &block)
    @thread.value.send(*args,&block)
  end
end
