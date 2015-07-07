class Poly
	def initialize
		@pow = []
		@nb = []
		@sign = []
	end

	def Gsign
		@sign
	end

	def Ssign(nsign)
		@sign = nsign
	end

	def Gpow(i)
		@pow[i]
	end

	def Spow(npow, i)
		@pow[i] = npow
	end

	def Gnb(i)
		@nb[i]
	end

	def Snb(nnb, i)
		@nb[i] = nnb
	end

	def Add_pow(nnb, npow)
		i = 0
		while @pow[i] != nil do
			if @pow[i] == npow then
				@nb[i] = @nb[i] + nnb
				test = @nb[i].to_s
				if test[0] == '-' then
					@sign[i] = '-'
				else
					@sign[i] = '+'
				end
				return
			end
			i += 1
		end
		@pow[i] = npow
		@nb[i] = nnb
		test = @nb[i].to_s
		if test[0] == '-' then
			@sign[i] = '-'
		else
			@sign[i] = '+'
		end
	end

	def Add_pol(new_pol)
		i = 0
		while new_pol.Gpow(i) != nil do
			Add_pow(new_pol.Gnb(i), new_pol.Gpow(i))
			i += 1
		end
	end

	def Inv_pol
		i = 0
		npol = Poly.new
		while @pow[i] != nil do
			npol.Snb(-@nb[i], i)
			npol.Spow(@pow[i], i)
			i += 1
		end
		npol
	end

	def Ord_pol
		npow = []
		nnb = []
		nsign = []
		i = 0
		k = 0
		while i <= self.Degres do
			j = 0
			while @pow[j] != nil do
				if @pow[j] == i then
					npow[k] = @pow[j]
					nnb[k] = @nb[j]
					nsign[k] = @sign[j]
					k += 1
				end
				j += 1
			end
			i += 1
		end
		@pow = npow
		@nb = nnb
		@sign = nsign
	end

	def Red_pol
		i = @pow.length - 1
		while i >= 0 do
			if @nb[i] == 0 then
				@pow.delete_at(i)
				@nb.delete_at(i)
				@sign.delete_at(i)
			end
			i -= 1
		end
	end

	def If_deg(nb)
		i = 0
		test = false
		while @pow[i] != nil do
			if @pow[i] == nb then
				test = true
			end
			i += 1
		end
		test
	end

	def Add_zcoef
		deg = self.Degres
		i = 0
		while i < deg do
			if self.If_deg(i) == false then
				self.Add_pow(0, i)
			end
			i += 1
		end
	end

	def Cmp_pol(pol)
		test = true
		if pol.Gsign.length != @sign.length then
			test = false
		else
			nsign = pol.Gsign
			i = 0
			while @pow[i] != nil do
				if @pow[i] != pol.Gpow(i) || @nb[i] != pol.Gnb(i) || @sign[i] != nsign[i] then
					test = false
				end
				i += 1
			end
		end
		test
	end

	def if_zeropol
		test = true
		i = 0
		while @nb[i] != nil do
			if @nb[i] != 0 then
				test = false
			end
			i += 1
		end
		test
	end

	def Get_nb(pow)
		i = 0
		test = -1
		while @pow[i] != nil do
			if @pow[i] == pow then
				test = @nb[i]
			end
			i += 1
		end
		test
	end

	def Delta
		delt = 0
		if self.Degres == 2 && self.If_deg(0) && self.If_deg(1)
			delt = ft_pow(self.Get_nb(1), 2) - (4 * self.Get_nb(2) * self.Get_nb(0))
		else
			delt = nil
		end
		delt
	end

	def Degres
		i = 0
		pow = 0
		while @pow[i] != nil do
			if @pow[i] > pow then
				pow = @pow[i]
			end
			i += 1
		end
		pow
	end

	def Real_degres
		i = 0
		pow = 0
		while @pow[i] != nil do
			if @pow[i] > pow && @nb[i] != 0 then
				pow = @pow[i]
			end
			i += 1
		end
		pow
	end

	def Aff_deg
		puts "Polynomial degree: #{self.Real_degres}"
	end

	def Aff_red
		i = 0
		print "Reduced form: "	
		if (self.if_zeropol)
			print '0'
		else
			i = 0
			if @sign[0] == '-' && i == 0 then
				print '-'
			end
			while @pow[i] != nil do
				if @pow[i] == 0 then
					self.Aff_zeropow(i)
				elsif @pow[i] == 1 then
					if @nb[i] == 1 || @nb[i] == -1 then
						print "X"
					else
						self.Aff_onepow(i)
					end
				elsif @nb[i] == 1 || @nb[i] == -1 then
					print "X^#{@pow[i]}"
				else
					self.Aff_norm(i)
				end
				i += 1
				if @sign[i] != nil then
					print " #{@sign[i]} "
				end
			end
		end
		puts ' = 0'
	end

	def Aff_norm(i)
		if ft_getdec(@nb[i]) == 0 then
			print "#{ft_abs(@nb[i].to_i)}*X^#{@pow[i]}"
		else
			print "#{ft_abs(@nb[i])}*X^#{@pow[i]}"
		end
	end

	def Aff_zeropow(i)
		if ft_getdec(@nb[i]) == 0 then
			print "#{ft_abs(@nb[i].to_i)}"
		else
			print "#{ft_abs(@nb[i])}"
		end
	end

	def Aff_onepow(i)
		if ft_getdec(@nb[i]) == 0 then
			print "#{ft_abs(@nb[i].to_i)}*X"
		else
			print "#{ft_abs(@nb[i])}*X"
		end
	end

	def Aff_test
		puts "nb:#{@nb}"
		puts "pow:#{@pow}"
		puts "sign:#{@sign}"
	end
end