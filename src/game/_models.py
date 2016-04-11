def instantiate(self, request, seed=None):
        """
        does not need to be server-side anymore
        """
        seedDict = json.loads(self.seedStructure)  
        
        # tidy seedStruct first 
        for k,v in seedDict.iteritems():     
            
            if 'default' not in v:
                seedDict['default'] = ''
            if 'type' not in v:
                seedDict[k]['type'] = 'string'

        # define seed from default
        if seed is None:
            seed = { k: {
                        'type':v['type'],
                        'value':v['default']
                    } for k,v in seedDict.iteritems() }
        
        for k,v in seed.iteritems():     

            if v['type'] == 'math':
                expr = SymbolicExpression(v['value'])
                sym = expr.latex(raw=True)
                v.update(sym)

        if request.user is None:
            user = request.user
        else:
            user = self.owner
            inst = GameInstance(
                game=self,
                instantiator=user,
                seed=json.dumps(seed),
            )

            for key, val in seed.iteritems():
                if type(val) == type(dict()) and 'value' in val:
                    value = val['value']
                    jsonval = json.dumps(val)
                else:
                    value = val
                    jsonval = json.dumps(val)

                try:
                    value = int(val)
                except ValueError:
                    pass

                
                seedkv = SeedKeyVal(key=key, val=value, jsonval=jsonval)
                seedkv.save()
                
                inst.seedParams.add(seedkv)

        inst.save()
        return inst