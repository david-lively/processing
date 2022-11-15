# # Constants for body
# HEAD_RADIUS = 35
# BODY_WIDTH = HEAD_RADIUS * 2
# BODY_HEIGHT = 60
# NUM_FEET = 3
# FOOT_RADIUS = (BODY_WIDTH) / (NUM_FEET * 2)

# # Constants for eyes
# PUPIL_RADIUS = 4
# PUPIL_LEFT_OFFSET = 8
# PUPIL_RIGHT_OFFSET = 20
# EYE_RADIUS = 10
# EYE_OFFSET = 14

# class Circle:
#     def __init__(self,radius):
#         self.radius = radius
#     def set_color(c):
#         self.color = c
        
# class Ghost:
#     def __init__(self,posX,posY)

# # class Ghost:
# #     def __init__(self,posX,posY,ghostColor):
# #         self.positionX = posX
# #         self.positionY = posY
# #         self.bodyColor = ghostColor
        
# #     def render(self):
# #         stroke(self.bodyColor)
# #         translate(self.positionX,self.positionY)
# #         circle(0,0,HEAD_RADIUS)
# """
# def get_width(mid_center_x, mid_center_y):

#     mid_center_x = get_width()/2
#     mid_center_y = get_height()/2

# Feet_list = [int((FOOT_RADIUS*2)-((FOOT_RADIUS*2)*2)), 0 ,int((FOOT_RADIUS*2))]

#    # This program has you draw a pacman ghost on the screen.
# def draw_ghost(center_x, center_y, color):
   
#     def Circle(radius):
 
#         head = Circle(HEAD_RADIUS)
#         head.set_position(center_x, center_y)
#         head.set_color(color)
   
#         body = Rectangle(BODY_WIDTH, BODY_HEIGHT)
#         body.set_position(center_x - HEAD_RADIUS, center_y)
#         body.set_color(color)
   
#     for i in Feet_list:
#         foot = Circle()
#         foot.set_position((center_x + i), center_y+ BODY_HEIGHT)
#         foot.set_color(color)
#         add(foot)
   
#     eye1 = Circle(EYE_RADIUS)
#     eye1.set_position(center_x - 14, center_y)
#     eye1.set_color(Color.white)
   
#     eye2 = Circle(EYE_RADIUS)
#     eye2.set_position(center_x + 14, center_y)
#     eye2.set_color(Color.white)
   
#     if center_x < mid_center_x:
#         pupil1 = Circle(PUPIL_RADIUS)
#         pupil1.set_position(center_x - 8, center_y)
#         pupil1.set_color(Color.blue)
   
#         pupil2 = Circle(PUPIL_RADIUS)
#         pupil2.set_position(center_x + 20, center_y)
#         pupil2.set_color(Color.blue)
       
#     else:
#         pupil1 = Circle(PUPIL_RADIUS)
#         pupil1.set_position(center_x - 20, center_y)
#         pupil1.set_color(Color.blue)
   
#         pupil2 = Circle(PUPIL_RADIUS)
#         pupil2.set_position(center_x + 8, center_y)
#         pupil2.set_color(Color.blue)
       
   
   
#     add(head)
#     add(body)
#     add(eye1)
#     add(eye2)
#     add(pupil1)
#     add(pupil2)
   
# x_coordinate = int(input("What is the Xcoordinate position?"))
# y_coordinate = int(input("What is the Ycoordinate position?"))
# ghostcolor = input("What is the color of the ghost?")

# draw_ghost(x_coordinate, y_coordinate, ghostcolor)

# x_coordinate1 = int(input("What is the Xcoordinate position?"))
# y_coordinate1 = int(input("What is the Ycoordinate position?"))
# ghostcolor1 = input("What is the color of the ghost?")

# draw_ghost(x_coordinate1, y_coordinate1, ghostcolor1)
# """
# # redGhost = Ghost(640,360,100)
# def setup():
#     size(1280,720)
    
# def draw():
#     background(0)
#     redGhost.render()
    
