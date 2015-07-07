require_relative 'Class.rb'
require_relative 'Function.rb'
require_relative 'Math.rb'

if (ARGV.length == 1 || ARGV.length == 2) then
	if ARGV.length == 1 then
		pol = ARGV[0].split("=")
		detail = false
	elsif ARGV[0] == "-detail"
		pol = ARGV[1].split("=")
		detail = true
	else
		ft_error 0
	end
	if (pol.length != 2) then
		ft_error 1
	end
	expr = Poly.new
	expr2 = Poly.new
	expr = ft_parse pol[0].delete(' ')
	expr2 = ft_parse pol[1].delete(' ')
	expr.Add_pol(expr2.Inv_pol)
	expr.Ord_pol
	expr.Red_pol
	expr.Aff_red
	expr.Add_zcoef
	expr.Ord_pol
	expr.Aff_deg
	if expr.if_zeropol then
		puts "All real number is solution."
	elsif expr.Degres > 2 then
		puts "The polynomial degree is stricly greater than 2, I can't solve."
	elsif expr.Degres == 0 then	
		puts "There are no solutions."
	elsif expr.Degres == 1 then
		ft_firstdeg(expr, detail)
	elsif expr.Degres == 2 then
		ft_secdeg(expr, detail)
	end
else
	ft_error 0
end
