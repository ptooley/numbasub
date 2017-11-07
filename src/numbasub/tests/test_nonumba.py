#!/usr/bin/env python3

import pytest

import numbasub.nonumba as nb

# can call the same decorator as any "numba" function
# decorated function should do the same as undecorated function
@pytest.mark.parametrize("decorator",
    [nb.autojit,
     nb.generated_jit,
     nb.guvectorize,
     nb.jit,
     nb.jitclass,
     nb.njit,
     nb.vectorize,
    ])
def test_nodecoratoroptions(decorator):
    @decorator
    def decorated(arg):
        return(arg)

    def undecorated(arg):
        return(arg)
        
    testobject = "somestring"

    assert(decorated(testobject) == undecorated(testobject))

