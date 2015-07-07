def ft_abs(nb)
	if (nb < 0)
		nb = -nb
	end
	nb
end

def ft_getdec(nb)
	nnb = nb.to_i
	nnb = nnb.to_f
	nb = nb - nnb
	nb
end

def ft_turni(nb)
	if ft_getdec(nb) == 0 then
		nb = nb.to_i
	end
	nb
end

def ft_pow(nb, pow)
	i = 0
	ret = 1
	while i < pow
		ret *= nb
		i += 1
	end
	ret
end

def ft_round(nb, ar)
	nb = nb.to_f.to_s
	i = 0
	str = ""
	while nb[i] != '.' do
		str[i] = nb[i]
		i += 1
	end
	str[i] = nb[i]
	i += 1
	j = 0
	while j < ar && nb[i] != nil do
		str[i] = nb[i]
		i += 1
		j += 1
	end
	str.to_f
end

def ft_sqrt(nb)
 	if nb == 0.0 then
    	ret = 0.0
  	else
    	m = 1.0
    	x = nb
    	while x >= 2.0 do
        	x = 0.25 * x
        	m = 2.0 * m
    	end
    	while  x < 0.5 do
    		x = 4.0 * x
       		m = 0.5 * m
    	end
    	a = x
    	b = 1.0 - x
    	a = a * (1.0 + 0.5 * b)
    	b = 0.25 * (3.0 + b) * b * b
    	while b >= 1.0E-15 do
    		a = a * (1.0 + 0.5 * b)
    		b = 0.25 * (3.0 + b) * b * b
    	end
    	ret = a * m
    end
    ret
end