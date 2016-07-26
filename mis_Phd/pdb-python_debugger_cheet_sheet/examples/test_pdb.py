from IPython.core.debugger import Tracer
debug_here = Tracer()

def fobar(n):
    x = 1337
    y = x + n
    debug_here() #this one triggers the debugger
    c1 = 'hello'
    print(c1)
    c2 = 'debugger'
    print(c2)
    return y

fobar(3)
