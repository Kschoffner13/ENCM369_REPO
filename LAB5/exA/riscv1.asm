






	li	t5, 0x6a009005
	li	t6, 0x0fffa000
	lui	t0, 0x0b670
	srli	t1, t0, 5
	slli	t2, t0, 3
	or	t3, t5, t6
	andi	t4, t5, 0x3ff
	xor	s0, t5, t6
	xori	s1, t5, -16