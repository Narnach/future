# Future implements the future concept from IO.
# A future is an object that you create now, but which only gets a usable
# value in the future. Think of asynchronous messaging and long-lasting method
# calls.
#
# An example:
#   include Future
#   f = future { sleep 5; 123}
#   puts f * 5 #=> 615
# The future will take 5 seconds to run, then 123 is returned.
# The call f.*(5) will block until the future is done.
#
# Another example:
#   include Future
#   f1 = future { sleep 5; 10}
#   f2 = future { sleep 3; 20}
#   f3 = future { sleep 1; 30}
#   puts f3 + f2 + f1
# Here it only takes 5 seconds to calculate the sum instead of the 9 it would take when done sequentially.
module Future
  def future(&block)
    t = Thread.new(&block)
    class << t
      (instance_methods - %w[value __send__ __id__]).each do |meth|
        eval("undef #{meth}")
      end
      def method_missing(*args, &block)
        value.send(*args,&block)
      end
    end
    t
  end
end
