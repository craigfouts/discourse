'''
Author(s): Craig Fouts
Correspondence: c.fouts25@imperial.ac.uk
License: Apache 2.0 license
'''

import pyreadr

__all__ = [
    'read_rda'
]

def read_rda(path):
    df = pyreadr.read_r(path)[None]

    return df
