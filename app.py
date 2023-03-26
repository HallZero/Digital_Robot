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
    return render_template('index.html', x=robot.x, y=robot.y, z=robot.z, a=robot.a, b=robot.b, c=robot.c)

@app.route('/test')
def test():
    return 'teste'

@app.route('/position', methods=['POST'])
def position():
    if request.method == 'POST':
        robot.new_position_axes(request.form['x'], request.form['y'], request.form['z'])
        robot.new_position_angles(request.form['a'], request.form['b'], request.form['c'])
        session.add(robot)
        session.commit()
        return redirect(url_for('index'))
    
@app.route('/axes')
def axes():
    return jsonify({'x': robot.x, 'y': robot.y, 'z': robot.z, 'a': robot.a, 'b': robot.b, 'c': robot.c})

if __name__ == '__main__':
    app.run(host = '0.0.0.0', port=3000, debug=True)
