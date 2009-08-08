#!/usr/bin/env python
from distutils.core import setup
setup(name='volreg',
    version='0.6',
    packages=["forensics", "forensics.win32","memory_plugins","memory_plugins.registry","memory_objects","memory_objects.Windows"],
)
