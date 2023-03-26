from models.Base import Base
from sqlalchemy import Column, Integer

class Position(Base):
    __tablename__ = 'positions'
    id = Column(Integer, primary_key=True)
    x = Column(Integer)
    y = Column(Integer)
    z = Column(Integer)
    a = Column(Integer)
    b = Column(Integer)
    c = Column(Integer)

    def __init__(self):
        self.x = 0
        self.y = 0
        self.z = 0
        self.a = 0
        self.b = 0
        self.c = 0

    def new_position_axes(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z

    def new_position_angles(self, a, b, c):
        self.a = a
        self.b = b
        self.c = c

    def __repr__(self):
        return '<Position %r>' % (self.name)