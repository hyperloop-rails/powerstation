$fast_random = nil
class Fast_random
	def initialize(seed)
		@seed = seed
		@seed_base = [1, 3, 2, 2, 4, 2, 3, 1, 0, 5, 2, 4, 3, 1, 6, 3, 1, 1, 4, 2, 7, 4, 3, 1, 5, 2, 8, 4, 0, 3, 9, 2, 1, 7, 3, 5, 2, 8, 6, 11, 9, 2, 3, 5, 0, 0, 1, 8, 2, 11, 4, 5, 3, 7, 1, 8, 2, 6, 0, 1, 3, 5, 9, 2, 1, 6, 3, 4, 4, 7, 2, 8, 3, 1, 5, 0, 3, 4, 8]
	end
	def internal_next(bits)
    @seed = (@seed * 0x5DEECE66D + 0xB) & ((1 << 48) - 1);
    return (@seed >> (48 - bits));
  end
	def next
    return (self.internal_next(32) << 32) + self.internal_next(32);
  end
	def next_bound(lower, upper)
		return lower + @seed_base[self.next.modulo(@seed_base.length)].modulo(upper-lower)
	end
end
