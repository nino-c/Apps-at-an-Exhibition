from django.test import TestCase
import sys
from views import SymbolicExpression

# Create your tests here.
if __name__ == '__main__':
    expr = SymbolicExpression(sys.argv[1])
    print expr.latex()