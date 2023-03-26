from flask import Flask, render_template, request, redirect, url_for, flash, jsonify
import sqlalchemy
from models.Base import Base
from models.Position import Position

app = Flask(__name__)

engine = sqlalchemy.create_engine("sqlite+pysqlite:///database.db", echo=True)

Session = sqlalchemy.orm.sessionmaker(bind=engine)
session = Session()

Base.metadata.create_all(engine)

robot = Position()

@app.route('/')
def index():
    return render_template('index.html', x=robot.x, y=robot.y, z=robot.z)

@app.route('/test')
def test():
    return 'teste'

@app.route('/position', methods=['POST'])
def position():
    if request.method == 'POST':
        robot.new_position_axes(request.form['x'], request.form['y'], request.form['z'])
        session.add(robot)
        session.commit()
        return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(host = '0.0.0.0', port=3000, debug=True)
