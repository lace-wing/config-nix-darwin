local M = {}

M.inline_equation = {
	prefix = 'm',
	body = [[\$$1\$]]
}

M.block_equation = {
	prefix = 'mm',
	body = [[
\$
	$0
\$]]
}

M.equation_super = {
	prefix = 'sp',
	body = '$1^($2)'
}

M.equation_sub = {
	prefix = 'sb',
	body = '$1_($2)'
}

M.fraction = {
	prefix = 'fr',
	body = '($1) / ($2)'
}

M.integral = {
	prefix = 'in',
	body = 'integral_($1)^($2) '
}

M.integral_double = {
	prefix = 'di',
	body = 'integral.double'
}

M.integral_triple = {
	prefix = 'ti',
	body = 'integral.triple'
}

M.limits = {
	prefix = 'lm',
	body = 'limits($1)'
}

M.range_inclusive_exclusive = {
	prefix = 'ie',
	body = '[$0)'
}

M.range_exclusive_inclusive = {
	prefix = 'ei',
	body = '($0]'
}

M.inline_code = {
	prefix = 'c',
	body = '```$1 $2```'
}

M.block_code = {
	prefix = 'cc',
	body = [[
```$1
$0
```]]
}

return M
