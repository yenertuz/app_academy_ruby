MAX_STACK_SIZE = 200
tracer = proc do |event|
  if event == 'call' && caller_locations.length > MAX_STACK_SIZE
    fail "Probable Stack Overflow"
  end
end
set_trace_func(tracer)