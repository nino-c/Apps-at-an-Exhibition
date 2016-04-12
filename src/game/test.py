

seed = {
	"NUM_ITERATIONS": {"type": "number", "value": 5, "parsing": False}, 
	"COLOR1": {"type": "color", "value": "#785A3C", "parsing": False}, 
	"COLOR2": {"type": "color", "value": "#27cc24", "parsing": False}, 
	"TRAPEZOIDAL_SECTIONS": {"type": "number", "value": "13", "parsing": False}, 
	"DEGREE2_COEFF": {"type": "number", "value": 33, "parsing": False}, 
	"CHILDREN": {"type": "javascript", "value": "[4,6,8,-7]", "parsing": False}, 
	"DEGREE1_COEFF": {"type": "number", "value": 36, "parsing": False}
}

seedDict = {
	"COLOR1": {"default": "#785A3C"},
	"COLOR2": {"type": "color", "default": "#00AA00"},
  	"NUM_ITERATIONS":{"type": "number", "default":5, "min": 2, "max": 13},
	"CHILDREN": {"type": "javascript", "default": "[6,-7,8,12]"},
	"TRAPEZOIDAL_SECTIONS": {"type": "number", "default":15, "min": 5, "max": 50},
	"DEGREE1_COEFF": {"type": "number", "default":17, "min": 1, "max": 1000},
	"DEGREE2_COEFF": {"type": "number", "default":30, "min": 1, "max": 1000}
}

#seed={}

for k,v in seedDict.iteritems():     
    if 'type' not in v:
        v['type'] = 'string'
    if 'default' not in v:
        if v['type'] == 'number':
            v = 0
        else:
            v = ''
    seed[k] = {'type':v['type'], 'value':v['default']}

for k,v in seed.iteritems():     
    if v['type'] == 'math':
        expr = SymbolicExpression(v['value'])
        sym = expr.latex(raw=True)
        v.update(sym)
    if v['type'] == 'number':
        try:
            v['value'] = int(v['value'])
        except Exception:
            pass
    
print seed