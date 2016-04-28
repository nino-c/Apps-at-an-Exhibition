from __future__ import division

from django.http import HttpResponse, JsonResponse
from django.http import HttpResponseBadRequest
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt

from rest_framework.response import Response
from rest_framework.permissions import AllowAny

from sympy import *
from sympy.parsing.sympy_parser import parse_expr
from sympy.parsing.sympy_parser import (parse_expr, standard_transformations, 
    implicit_multiplication, implicit_multiplication_application, 
    split_symbols, function_exponentiation, convert_xor,
    auto_number, auto_symbol)
from sympy.printing.latex import *

from jscode import *


class SymbolicExpression(object):
    
    def __init__(self, expressionString):
        self.expressionString = expressionString
        try:
            transformations = standard_transformations + (implicit_multiplication,
                implicit_multiplication_application, split_symbols, 
                function_exponentiation, convert_xor)
            self.expression = parse_expr(expressionString, evaluate=False, 
            transformations=transformations)

            print "expr", self.expressionString

        except SyntaxError, e:
            raise Exception("Bad syntax")

        self.javascript = jscode(self.expression)

    def latex(self, request=None, raw=False):
        self.latex = latex(self.expression, mode='plain')
        obj = {'string':self.expressionString, 
            'javascript': self.javascript, 'latex':self.latex}
        if (raw):
            return obj
        else:
            return JsonResponse(obj)

@csrf_exempt
#permission_classes((AllowAny,))
def exec_function(request, funcname):
    """
    Accepts a function name as a GET parameter,
    and an JSON object representing an expression 
    as a POST parameter
    """
    if request.method == "POST":
        expressionString = request.POST.get('expressionString')
        print request.POST, expressionString
        expression = SymbolicExpression(expressionString)
        if hasattr(expression, funcname):
            method = getattr(expression, funcname)
            if callable(method):
                return method.__call__(request)
    else:
        return HttpResponseBadRequest()

def index(request):
    return render(request, "symbolic_math/symmath.html")