def range(start, end_)
	return Array.new(start) if end_ <= start
	return Array.new(end_) + range(end_ - 1)
end

def exp1(b, n)
	return 1 if n <= 0
	return b * exp1(b, n - 1)
end

def exp2(b, n)
	return 1 if n <= 0
	return b if n == 1
	return exp2(b, n / 2) ** 2 if n.even?
	return b * exp2(b, ( (n - 1) / 2 ) ** 2)
end

def deep_dup(input)
	return Array.new(1, input) if input.is_a?(Array) == false
	return deep_dup(input[0]) if input.length <= 1
	return deep_dup(input[0]) + deep_dup(input[1..-1])
end

def r_fib(n)
	return nil if n < 1
	return 1 if n == 1
	return n * r_fib(n - 1)
end

def i_fib(n)
	return nil if n < 1
	(1..n).reduce(:*)
end

def b_search(array, target)
	l = n.length
	return nil if l == 0
	m = l / 2
	return m if array[m] == target
	if target < array[m]
		return b_search(array[0...m], target)
	else
		return m + b_search(array[(m + 1)..-1])
	end
end

def merge_helper(arr1, arr2)
	r = []
	while arr1.length > 0 && arr2.length > 0
		if arr1[0] > arr2[0]
			r.push(arr2.shift)
		else
			r.push(arr1.shift)
		end
	end
	r.push(arr1.shift) if arr1.length > 0
	r.push(arr2.shift) if arr2.legnth > 0
	r 
end

def merge_sort(array)
	return array if array.length <= 1
	l = array.length
	m = l / 2
	merge_helper(merge_sort(array[0..m], merge_sort(array[(m + 1)..-1])))
end

def array_subsets(array)
	return [[]] if array.length == 0
	return array_subsets(array[1..-1]) + array_subsets(array[1..-1]).map {|x| x << array[0] }
end

def greedy_make_change(total, changes=[25, 10, 5, 1])
	changes.sort!
	r = []
	while total > 0
		while total < changes[-1]
			changes.pop
		end
		r << changes[-1]
		total -= changes[-1]
	end
	r
end