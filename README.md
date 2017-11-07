# numbasub

Numbasub is a shim module designed to allow numba to be made an optional runtime dependency of
packages.  Depending on how deeply numba is integrated into a package it may not be feasible to
make numba optional, however, for the typical case that only the top level decorator functions are
used, then simply replacing the numba decorators with no-ops should work just fine.
