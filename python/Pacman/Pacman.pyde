# Constants for body
HEAD_RADIUS = 35
BODY_WIDTH = HEAD_RADIUS * 2
BODY_HEIGHT = 60
NUM_FEET = 3
FOOT_RADIUS = (BODY_WIDTH) / (NUM_FEET * 2)

# Constants for eyes
PUPIL_RADIUS = 4
PUPIL_LEFT_OFFSET = 8
PUPIL_RIGHT_OFFSET = 20
EYE_RADIUS = 10
EYE_OFFSET = 14

def get_width(mid_center_x, mid_center_y):

    mid_center_x = get_width()/2
    mid_center_y = get_height()/2

Feet_list = [int((FOOT_RADIUS*2)-((FOOT_RADIUS*2)*2)), 0 ,int((FOOT_RADIUS*2))]

"""
   This program has you draw a pacman ghost on the screen.
"""

class Circle:
    
    def __init__(self,radius):
        self.radius = radius
        self.color=color(255) # set default color to white
        
        # set initial position to center of the window
        self.center_x = width / 2 
        self.center_y = height / 2
        
    def set_color(self, circleColor):
        self.color=circleColor
        
    def set_position(self,x,y):
        self.center_x = x
        self.center_y = y
        
    
def draw_ghost(center_x, center_y, body_color):
    body = {}
    head = Circle(HEAD_RADIUS)
    head.set_position(center_x, center_y)
    head.set_color(color)

    # body = Rectangle(BODY_WIDTH, BODY_HEIGHT)
    # body.set_position(center_x - HEAD_RADIUS, center_y)
    # body.set_color(color)

    for i in Feet_list:
        foot = Circle(FOOT_RADIUS)
        foot.set_position((center_x + i), center_y+ BODY_HEIGHT)
        foot.set_color(color)
        body.add(foot)
   
    eye1 = Circle(EYE_RADIUS)
    eye1.set_position(center_x - 14, center_y)
    eye1.set_color(Color.white)
   
    eye2 = Circle(EYE_RADIUS)
    eye2.set_position(center_x + 14, center_y)
    eye2.set_color(Color.white)
   
    if center_x < mid_center_x:
        pupil1 = Circle(PUPIL_RADIUS)
        pupil1.set_position(center_x - 8, center_y)
        pupil1.set_color(Color.blue)
   
        pupil2 = Circle(PUPIL_RADIUS)
        pupil2.set_position(center_x + 20, center_y)
        pupil2.set_color(Color.blue)
       
    else:
        pupil1 = Circle(PUPIL_RADIUS)
        pupil1.set_position(center_x - 20, center_y)
        pupil1.set_color(Color.blue)
   
        pupil2 = Circle(PUPIL_RADIUS)
        pupil2.set_position(center_x + 8, center_y)
        pupil2.set_color(Color.blue)
       
   
   
    add(head)
    add(body)
    add(eye1)
    add(eye2)
    add(pupil1)
    add(pupil2)
   
# x_coordinate = int(input("What is the Xcoordinate position?"))
x_coordinate = 200
y_coordinate = 200
# y_coordinate = int(input("What is the Ycoordinate position?"))
# ghostcolor = input("What is the color of the ghost?")
ghostcolor = color(255,0,0) # red
draw_ghost(x_coordinate, y_coordinate, ghostcolor)

# x_coordinate1 = int(input("What is the Xcoordinate position?"))
# y_coordinate1 = int(input("What is the Ycoordinate position?"))
x_coordinate1 = 600
y_coordinate1 = 200
# ghostcolor1 = input("What is the color of the ghost?")
ghostcolor1 = color(0,255,0) #green

draw_ghost(x_coordinate1, y_coordinate1, ghostcolor1)

def setup():
    size(1280,720)

def draw():
    background(0)
