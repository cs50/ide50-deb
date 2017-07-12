from astroid import MANAGER
from astroid import scoped_nodes


def register(linter):
    pass


def transform(cls):
    """ Stop pylint from complaining about cs50.SQL """

    if cls.name == 'cs50':
        import cs50
        cls.locals["SQL"] = [scoped_nodes.Class("SQL", None)]

MANAGER.register_transform(scoped_nodes.Module, transform)
