if (defined?(Net) && defined?(Net::HTTP))

  Net::HTTP.class_eval do
    def request_with_mini_profiler(*args, &block)
      request = args[0]
      Rack::MiniProfiler.step("Net::HTTP #{request.method} #{request.path}") do
        request_without_mini_profiler(*args, &block)
      end
    end
    alias request_without_mini_profiler request
    alias request request_with_mini_profiler

    def connect_with_mini_profiler(*args, &block)
      Rack::MiniProfiler.step("Opening Connection") do
        connect_without_mini_profiler(*args, &block)
      end
    end
    alias connect_without_mini_profiler connect
    alias connect connect_with_mini_profiler

    def transport_request_with_mini_profiler(*args, &block)
      Rack::MiniProfiler.step("Transporting Data") do
        transport_request_without_mini_profiler(*args, &block)
      end
    end
    alias transport_request_without_mini_profiler transport_request
    alias transport_request transport_request_with_mini_profiler
  end
end
