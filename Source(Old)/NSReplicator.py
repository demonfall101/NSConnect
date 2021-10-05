from socket import AF_INET, socket, SOCK_STREAM
from threading import Thread
import socket as sc
import pickle, os, sys, time, random
from os import path
import ctypes

if not path.exists("id.ns"):
    file = open("id.ns", "w+")
    file.write(str(random.randint(0, 9999)).zfill(4))
    file.close()

fileid = open("id.ns")
idnum = fileid.read()
fileid.close()

if path.exists("data.ns"):
    os.remove("data.ns")
    file = open("data.ns", "w+")
    file.close()
else:
    file = open("data.ns", "w+")
    file.close()

def receive():
    """Handles receiving of messages."""
    while True:
        try:
            msg = client_socket.recv(BUFSIZ).decode("utf8")
            if idnum != msg.split(':')[0]:
                print (msg)
                f1 = open("output.ns", "w+")
                f1.write(msg)
                f1.close()
        except OSError:  # Possibly client has left the chat.
            break

def send(msg):  # event is passed by binders.
    """Handles sending of messages."""
    client_socket.send(bytes(msg, "utf8"))
    if msg == "{quit}":
        client_socket.close()
        os.startfile("endProcess.exe")
        sys.exit()

def on_closing():
    """This function is to be called when the window is closed."""
    try:
        send("{quit}")
        sys.exit()
    except:
        sys.exit()

#----Now comes the sockets part----
q1 = input('Are you the host? [y/n/yes/no]\n>>>')
me = False
if (q1.upper() == "Y") or (q1.upper() == "YES"):
    os.startfile("NSReplicatorServer.exe")
    me = True

if not me:
    HOST = input('Enter host ip: ')
else:
    hostname = sc.gethostname()
    HOST = sc.gethostbyname(hostname)
PORT = 5555

BUFSIZ = 1024
ADDR = (HOST, PORT)

client_socket = socket(AF_INET, SOCK_STREAM)
while (True):
    try:
        client_socket.connect(ADDR)
        break
    except:
        pass
ctypes.windll.user32.ShowWindow( ctypes.windll.kernel32.GetConsoleWindow(), 6 )
client_socket.send(bytes(idnum, "utf8"))

receive_thread = Thread(target=receive)
receive_thread.start()

x = ""
while True:
    myfile = open("data.ns")
    txt = myfile.read()
    if x != txt:
        x = txt
        send(txt)
            






