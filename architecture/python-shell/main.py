import os
import signal
import time

forground_jobs = {}
background_jobs = {}
messages = []


def getcwd():
    cwd = os.getcwd()
    for i in range(len(cwd)-1,0,-1):
        if cwd[i] == "/":
            return cwd[i+1:]


def redirectOutput(output_source):
    fd = os.open(output_source, os.O_WRONLY | os.O_TRUNC | os.O_CREAT, 0o644)
    os.dup2(fd, 1)
    os.close(fd)
def redirectInput(input_source):
    fd = os.open(input_source, os.O_RDONLY)
    os.dup2(fd, 0)
    os.close(fd)
def redirection(input_list, i):
    try:
        if input_list[i] == '>':
            redirectOutput(input_list[i+1])
        if input_list[i] == '<':
            redirectInput(input_list[i+1])
        return True
    except:
        messages.append("Invalid redirect.")
        return False


def executeCommand(cmd, input_list, background):
    pid = os.fork()

    if pid > 0:
        if background:
            background_jobs[pid] = cmd + ' ' + str(input_list[1:])
        else:
            forground_jobs[pid] = cmd + ' ' + str(input_list[1:])
    else:
        args = [cmd]
        valid_redirect = True
        for i in range(1,len(input_list)):
            if input_list[i] == '>':
                valid_redirect = redirection(input_list, i)
                break
            if input_list[i] == '<':
                valid_redirect = redirection(input_list, i)
                break
            args.append(input_list[i])
        if valid_redirect:
            os.execvp(cmd, args)
        else:
            pass


def parsePipe(input_list, background):
    for i in range(len(input_list)):
        if input_list[i] == '|':
            pipe_location = i
            break
    lhs_list = input_list[0:pipe_location]
    rhs_list = input_list[pipe_location+1:]

    cmd_lhs = lhs_list[0]
    cmd_rhs = rhs_list[0]
    args_lhs = []
    args_rhs = []
    for i in range(len(lhs_list)): 
        args_lhs.append(lhs_list[i])
    for i in range(len(rhs_list)):
        args_rhs.append(rhs_list[i])

    pipeCommands(cmd_lhs, args_lhs, cmd_rhs, args_rhs, background)

def pipeCommands(cmd_lhs, args_lhs, cmd_rhs, args_rhs, background):
    (read_end, write_end) = os.pipe()

    pid0 = os.fork()
    if pid0 > 0:
        pid1 = os.fork()
        if pid1 > 0:
            os.close(read_end)
            os.close(write_end)
            if background:
                background_jobs[pid0] = cmd_lhs + ' ' + str(args_lhs)
                background_jobs[pid1] = cmd_rhs + ' ' + str(args_rhs)
            else:
                forground_jobs[pid0] = cmd_lhs + ' ' + str(args_lhs)
                forground_jobs[pid1] = cmd_rhs + ' ' + str(args_rhs)
        else:
            os.dup2(read_end, 0)
            os.close(read_end)
            os.close(write_end)
            os.execvp(cmd_rhs, args_rhs)

    else:
        os.dup2(write_end, 1)
        os.close(read_end)
        os.close(write_end)
        os.execvp(cmd_lhs, args_lhs) 


def changeDirectory(input_list):
    if len(input_list) == 2:
        directory_change = input_list[1]
        tryDirectoryChange(directory_change)
    elif len(input_list) == 1:
        directory_change = os.getenv('HOME')
        tryDirectoryChange(directory_change)
    else:
        messages.append("Invalid directory")
def tryDirectoryChange(directory_change):
    try:
        os.chdir(directory_change)
    except:
        messages.append("Invalid directory")


def grimReaper(a, b):
    (pid, status) = os.waitpid(0, os.WNOHANG)
    if os.WIFEXITED(status):
        messages.append(str(pid) + ' ' + "Complete")
        forground_jobs.pop(pid, None)
        background_jobs.pop(pid, None)

        if os.WEXITSTATUS(status) != 0:
            messages.append(str(pid) + ' ' + "Error")

    return
signal.signal(signal.SIGCHLD, grimReaper)

def main():
    while True:
        while len(forground_jobs) > 0:
            time.sleep(.05)
        for i in range(len(messages)):
            print(messages[i])
        for i in range(len(messages)):
            messages.pop()

        cwd = getcwd()
        background = False
        try:
            user_input = input("shell-emulator:" + cwd + "$ ")
            if len(user_input) > 0:
                if user_input[-1] == '&':
                    background = True
                    user_input = user_input[0:len(user_input)-1]
            input_list = user_input.split()
        except:
            print('\n' + 'Okay, goodbye')
            break
        if user_input == "exit":
            print('Okay, goodbye')
            break


        if len(input_list) > 0:
            cmd = input_list[0]
            if cmd == 'cd':
                changeDirectory(input_list)
            elif cmd == 'jobs':
                for key in background_jobs:
                    print(str(key) + ' ' + background_jobs[key])
            elif '|' in input_list:
                parsePipe(input_list, background)
            else:
                executeCommand(cmd, input_list, background)

main()
