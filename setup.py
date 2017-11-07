#!/usr/bin/env python

from setuptools import setup, find_packages

setup(name='numbasub',
      version='0.1',
      description='Allows making numba optional by providing no-op '
                  'replacements for numba decorator functions.',
      author='Phil Tooley',
      author_email='phil.tooley@protonmail.ch',
      url='numbasub.github.io',
      package_dir={'': 'src'},
      packages=find_packages('src', exclude='tests'),
     )
