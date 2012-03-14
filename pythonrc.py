import inspect
import pydoc
import rlcompleter
import readline

readline.parse_and_bind("tab: complete")

def source(obj):
    """source of the obj."""
    try:
        pydoc.pipepager(inspect.getsource(obj), "less")
    except IOError:
        pass