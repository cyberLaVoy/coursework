from stack import Stack
from config import *

def detectPriority(operand_a, operand_b):
    priority = False
    priorities = {"+" : 1, "-" : 1, "*" : 2, "/" : 2}
    if priorities[operand_a] < priorities[operand_b]:
        priority = True
    return priority

def infixTOpostfix(user_input):
    stack = Stack()
    expression = ""
    for i in range(len(user_input)):
        ui = user_input[i]
        if ui not in supported_characters: 
            expression += ui
        else:
            if ui == "(":
                stack.push("(")
            elif ui == ")":
                while stack.top() != "(":
                    expression += stack.pop()
                stack.pop()
            else:
                if stack.isEmpty() or stack.top() == "(":
                    stack.push(ui)
                else:
                    if not detectPriority(stack.top(), ui):
                        expression += stack.pop()
                    stack.push(ui)
    while not stack.isEmpty():
        expression += stack.pop()
    return expression

def evaluateExpression(stack, e, x):
    if e not in supported_characters:
        if e == "x":
            e = x
        stack.push(e)
    if e == "+":
        r = stack.pop()
        l = stack.pop()
        stack.push(float(l)+float(r))
    if e == "-":
        r = stack.pop()
        l = stack.pop()
        stack.push(float(l)-float(r))
    if e == "*":
        r = stack.pop()
        l = stack.pop()
        stack.push(float(l)*float(r))
    if e == "/":
        r = stack.pop()
        l = stack.pop()
        stack.push(float(l)/float(r))

def evaluatePostfix(expression, x_values, y_values):
    stack = Stack()
    x = x_low
    while x <= x_high:
        x_values.append(x)
        for i in range(len(expression)):
            e = expression[i]
            evaluateExpression(stack, e, x)
        y = float(stack.pop())
        y_values.append(y)
        x += x_inc

def drawXYpairs(x_values, y_values):
    for i in range(len(x_values)-1):
        p1 = Point(x_values[i], y_values[i])
        p2 = Point(x_values[i+1], y_values[i+1])
        l = Line(p1, p2)
        l.setWidth(1)
        l.setOutline("blue")
        l.draw(win)

def drawAxes():
    l = Line( Point(x_low,(y_high+y_low)/2), Point(x_high,(y_high+y_low)/2) )
    l.setOutline("black")
    l.draw(win)
    l = Line( Point((x_low+x_high)/2,y_low), Point((x_low+x_high)/2,y_high) )
    l.setOutline("black")
    l.draw(win)

def continueGraphing():
    resume = False
    c = input("Continue? ")
    if c[0] == 'y' or c[0] == 'Y':
        resume = True
    return resume

def main():
    drawAxes()

    resume = True
    while resume:
        x_values = []
        y_values = [] 
        print("input your expression below")
        user_input = input("y = ")
        expression = infixTOpostfix(user_input)
        evaluatePostfix(expression, x_values, y_values)
        drawXYpairs(x_values, y_values)
        resume = continueGraphing()
        
    win.close() 
main()
