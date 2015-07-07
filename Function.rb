def ft_parse(equ)
	poly = Poly.new
	sign = []
	if equ[0] == '-' then
		equ[0] = ' '
		sign[0] = '-'
	elsif equ[0] == '+' then
		equ[0] = ' '
		sign[0] = '+'
	else
		sign[0] = '+'
	end
	i = 0
	j = 1
	while equ[i] != nil do
		if equ[i] == '-' || equ[i] == '+'
			sign[j] = equ[i]
			j += 1
		end
		i += 1
	end
	equ = equ.delete(' ')
	str = equ.split(%r{[+-]})
	poly = ft_fillpol(str, sign)
end

def ft_fillpol(str, sign)
	poly = Poly.new
	i = 0
	while str[i] != nil do
		mb = str[i].split(%r{[*^]})
		if mb.length != 3 then
			if mb.length == 1 then
				if ft_isfloat(mb[0].to_s) then
					poly.Add_pow((sign[i] + mb[0]).to_f, 0)
				elsif mb[0] == 'X' || mb[0] == 'x' then
					poly.Add_pow((sign[i] + '1').to_f, 1)
				else
					ft_error 1
				end
			elsif mb.length == 2 then
				if (mb[0] == 'X' || mb[0] == 'x') && ft_isinterger(mb[1]) then
					poly.Add_pow((sign[i] + '1').to_f, mb[1].to_i)
				elsif ft_isfloat(mb[0]) && (mb[1] == 'X' || mb[1] == 'x')
					poly.Add_pow((sign[i] + mb[0]).to_f, 1)
				else
					ft_error 1
				end
			else
				ft_error 1
			end
		else
			if ft_isfloat(mb[0]) == false || ft_isinterger(mb[2]) == false then
				ft_error 1
			elsif mb[1] != 'X' && mb[1] != 'x'
				ft_error 1
			else
				poly.Add_pow((sign[i] + mb[0]).to_f, mb[2].to_i)
			end
		end
		i += 1
	end
	poly
end

def ft_isinterger(str)
	i = 0
	ret = true
	if str[0] == '+' || str[0] == '-' then
		i += 1
	end
	while str[i] != nil do
		if str[i] < '0' || str[i] > '9' then
			ret = false
		end
		i += 1
	end
	ret
end

def ft_isfloat(str)
	i = 0
	test = 0
	ret = true
	if str[0] == '+' || str[0] == '-' then
		i += 1
	end
	while str[i] != nil do		
		if str[i] == '.' then
			if test == 1 then
				ret = false
			end
			test = 1
		elsif str[i] < '0' || str[i] > '9' then
			ret = false
		end
		i += 1
	end
	ret
end

def ft_error(nb)
	if nb == 0 then
		puts "Error: polynome.rb [-detail] polynome"
	elsif nb == 1 then
		puts "Error: Wrong input polynome format"
	end
	exit
end

def ft_retnbfi(nb)
	if ft_getdec(nb) == 0 then
		ret = nb.to_i
	else
		ret = nb
	end
	ret
end

def ft_firstdeg(expr, detail)
	puts "The solution is:"
	if detail == true then
		print "#{ft_retnbfi(expr.Get_nb(0))}"
		if expr.Get_nb(1).to_s[0] == '-' then
			print " - "
		else
			print " + "
		end
		puts "#{ft_abs(ft_retnbfi(expr.Get_nb(1)))} * X = 0"
		puts "#{(ft_retnbfi(expr.Get_nb(1)))} * X = #{ft_retnbfi(-expr.Get_nb(0))}"
		puts "X = #{ft_retnbfi(-expr.Get_nb(0))} / #{ft_retnbfi(expr.Get_nb(1))}"
	end
	puts "X = #{ft_turni(-expr.Get_nb(0) / expr.Get_nb(1))}"
end

def ft_secdeg(expr, detail)
	if detail == true then
		ft_delta(expr, detail)
	end
	if expr.Delta > 0 then
		ft_deltapos(expr, detail)
	elsif expr.Delta == 0 then
		ft_deltazero(expr, detail)
	else
		ft_deltaneg(expr, detail)
	end
end

def ft_delta(expr, detail)
	print "a * X ^ 2 + b * X + c with: a = #{ft_retnbfi(expr.Get_nb(2))}, b = #{ft_retnbfi(expr.Get_nb(1))}" 
	puts ", c = #{ft_retnbfi(expr.Get_nb(0))}"
	puts "Delta = b ^ 2 - 4 * a * c"
	if expr.Get_nb(1).to_s[0] == '-' then
		print "Delta = (#{ft_retnbfi(expr.Get_nb(1))})^2 - 4*"
	else
		print "Delta = #{ft_retnbfi(expr.Get_nb(1))}^2 - 4*"
	end
	if expr.Get_nb(2).to_s[0] == '-' then
		print "(#{ft_retnbfi(expr.Get_nb(2))})*"
	else
		print "#{ft_retnbfi(expr.Get_nb(2))}*"
	end
	if expr.Get_nb(0).to_s[0] == '-' then
		puts "(#{ft_retnbfi(expr.Get_nb(0))})"
	else
		puts "#{ft_retnbfi(expr.Get_nb(0))}"
	end
		puts "Delta = #{ft_retnbfi(expr.Delta)}"
end

def ft_deltapos(expr, detail)
	puts "Discriminant is strictly positive, the two solutions are:"
	if detail == true then
		puts "X1 = (-b + V(delta)) / (2 * a)"
		if expr.Get_nb(1).to_s[0] == '-' then
			print "X1 = (#{ft_abs(ft_retnbfi(expr.Get_nb(1)))}"
		else
			print "X1 = (-#{ft_retnbfi(expr.Get_nb(1))}"
		end
		if expr.Get_nb(2).to_s[0] == '-' then
			puts " + V#{ft_retnbfi(expr.Delta)}) / 2*(#{ft_retnbfi(expr.Get_nb(2))})"
		else
			puts " + V#{ft_retnbfi(expr.Delta)}) / 2*#{ft_retnbfi(expr.Get_nb(2))}"
		end
		print "X1 = #{-ft_retnbfi(expr.Get_nb(1)) + ft_sqrt(ft_retnbfi(expr.Delta))} / "
		puts "#{2 * ft_retnbfi(expr.Get_nb(2))}"
	end
	puts "X1 = #{ft_turni((-expr.Get_nb(1) + ft_sqrt(expr.Delta)) / (2 * expr.Get_nb(2)))}"
	if detail == true then
		puts "X2 = (-b - V(delta)) / (2 * a)"
		if expr.Get_nb(1).to_s[0] == '-' then
			print "X2 = (#{ft_abs(ft_retnbfi(expr.Get_nb(1)))}"
		else
			print "X2 = (-#{ft_retnbfi(expr.Get_nb(1))}"
		end
		if expr.Get_nb(2).to_s[0] == '-' then
			puts " - V#{ft_retnbfi(expr.Delta)}) / 2*(#{ft_retnbfi(expr.Get_nb(2))})"
		else
			puts " - V#{ft_retnbfi(expr.Delta)}) / 2*#{ft_retnbfi(expr.Get_nb(2))}"
		end
		print "X2 = #{-ft_retnbfi(expr.Get_nb(1)) - ft_sqrt(ft_retnbfi(expr.Delta))} / "
		puts "#{2 * ft_retnbfi(expr.Get_nb(2))}"
	end
	puts "X2 = #{ft_turni((-expr.Get_nb(1) - ft_sqrt(expr.Delta)) / (2 * expr.Get_nb(2)))}"
end

def ft_deltazero(expr, detail)
	puts "Discriminant is zero, the solution is:"
	if detail == true then
		puts "X = -b / (2 * a)"
		if expr.Get_nb(1).to_s[0] == '-' then
			print "X = #{ft_abs(ft_retnbfi(expr.Get_nb(1)))} / 2*"
		else
			print "X = -#{ft_retnbfi(expr.Get_nb(1))} / 2*"
		end
		if expr.Get_nb(2).to_s[0] == '-' then
			puts "(#{ft_retnbfi(expr.Get_nb(2))})"
		else
			puts "#{ft_retnbfi(expr.Get_nb(2))}"
		end
	end
	puts "X = #{ft_turni((-expr.Get_nb(1)) / (2 * expr.Get_nb(2)))}"
end

def ft_deltaneg(expr, detail)
	puts "Discriminant is strictly negative, the two complex solutions are:"
	if detail == true then
		puts "X1 = (-b + iV(-delta)) / (2 * a)"
		if expr.Get_nb(1).to_s[0] == '-' then
			print "X1 = (#{ft_abs(ft_retnbfi(expr.Get_nb(1)))}"
		else
			print "X1 = (-#{ft_retnbfi(expr.Get_nb(1))}"
		end
		if expr.Get_nb(2).to_s[0] == '-' then
			puts " + iV(#{-ft_retnbfi(expr.Delta)})) / 2*(#{ft_retnbfi(expr.Get_nb(2))})"
		else
			puts " + iV(#{-ft_retnbfi(expr.Delta)})) / 2*#{ft_retnbfi(expr.Get_nb(2))}"
		end
		print "X1 = (#{-ft_retnbfi(expr.Get_nb(1))} / #{2 * ft_retnbfi(expr.Get_nb(2))})"
		puts " + (#{ft_sqrt(ft_retnbfi(-expr.Delta))} / #{2 * ft_retnbfi(expr.Get_nb(2))})i"
	end
	if expr.Get_nb(2).to_s[0] == '-' then
		print "X1 = #{ft_turni((-expr.Get_nb(1))/(2 * expr.Get_nb(2)))} - "
	else
		print "X1 = #{ft_turni((-expr.Get_nb(1))/(2 * expr.Get_nb(2)))} + "
	end
	puts "#{ft_turni(ft_sqrt(-expr.Delta)/(2 * ft_abs(expr.Get_nb(2))))}i"
	if detail == true then
		puts "X2 = (-b - iV(-delta)) / (2 * a)"
		if expr.Get_nb(1).to_s[0] == '-' then
			print "X2 = (#{ft_abs(ft_retnbfi(expr.Get_nb(1)))}"
		else
			print "X2 = (-#{ft_retnbfi(expr.Get_nb(1))}"
		end
		if expr.Get_nb(2).to_s[0] == '-' then
			puts " - iV(#{ft_retnbfi(expr.Delta)})) / 2*(#{ft_retnbfi(expr.Get_nb(2))})"
		else
			puts " - iV(#{ft_retnbfi(expr.Delta)})) / 2*#{ft_retnbfi(expr.Get_nb(2))}"
		end
		print "X2 = (#{-ft_retnbfi(expr.Get_nb(1))} / #{2 * ft_retnbfi(expr.Get_nb(2))})"
		puts " - (#{ft_sqrt(ft_retnbfi(-expr.Delta))} / #{2 * ft_retnbfi(expr.Get_nb(2))})i"
	end
	if expr.Get_nb(2).to_s[0] == '-' then
		print "X2 = #{ft_turni((-expr.Get_nb(1))/(2 * expr.Get_nb(2)))} + "
	else
		print "X2 = #{ft_turni((-expr.Get_nb(1))/(2 * expr.Get_nb(2)))} - "
	end
	puts "#{ft_turni(ft_sqrt(-expr.Delta)/(2 * ft_abs(expr.Get_nb(2))))}i"
end