#!/usr/bin/python
# -*- coding: utf-8 -*-
#for python 3.7+
import os
import struct
import zlib
import binascii
fileDir = os.path.dirname(os.path.realpath('__file__'))
headerMap = { 'sign': (0, 8, '8s'), 'version': (8, 10, '2s'), 'locked': (10, 12, 'H'), 'entry_offset': (12, 16, 'I'), 'name_offset': (16, 20, 'I'), }

path = 'course.smpack'
stream = open(path, 'rb')
header_data = stream.read(20)
print(header_data)
print(header_data[:8])
data = {}
if header_data[:8]==b'-SMArch-':
    for (tag, (start, end, t)) in headerMap.items():
        #print(tag,start,end,t)
        (data[tag], ) = struct.unpack(t, header_data[start:end])        

entry_offset = data['entry_offset']
stream.seek(entry_offset)
(entry_count, ) = struct.unpack('I', stream.read(4))
entries = []
for i in range(entry_count):
    entry = {}
    (entry['name_offset'], ) = struct.unpack('I',stream.read(4))
    (entry['name_len'], ) = struct.unpack('H',stream.read(2))
    (entry['mode'], ) = struct.unpack('H', stream.read(2))
    (entry['data_offset'], ) = struct.unpack('I', stream.read(4))
    (entry['data_size'], ) = struct.unpack('I',stream.read(4))
    entries.append(entry)
files = {}
stream.seek(data['name_offset'])
(name_chunk_size, ) = struct.unpack('I', stream.read(4))
stream.seek(-name_chunk_size, 2)
name_chunk_begin = stream.tell()
for entry in entries:
    stream.seek(name_chunk_begin + entry['name_offset'])
    entry_name = stream.read(entry['name_len'])
    entry['name'] = entry_name
    files[entry_name] = entry
for entry in entries:
    print(entry['name'])
    entry_name = str(entry['name'])
    if entry_name.find("/")>-1:
        directory_name = entry_name.split("/")[0]
        directory_name = directory_name[2:]
        try:
            os.mkdir((directory_name))
        except:
            pass
        
    entry_name = str(entry['name'])
    if entry_name.find("/")>-1:
        directory_name = entry_name.split("/")[0]
        directory_name = directory_name[2:]
        file_name = entry_name.split("/")[1]
        stream.seek(entry['data_offset'])
        data = stream.read(entry['data_size'])
        try:
            data = zlib.decompress(data, -15)
            filename = os.path.join(fileDir, directory_name+"/"+file_name[:-1])
            f = open(filename, 'wb')
            f.write(data)
            f.close()    
        except:
            filename = os.path.join(fileDir, directory_name+"/"+file_name[:-1])
            f = open(filename, 'wb')
            f.write(data)
            f.close()   
for entry in entries:
    print(entry['name'])
    name = str(entry['name']).replace('/', '_')
    if name.find("_")==-1:
        name = name[2:-1]
        stream.seek(entry['data_offset'])
        data = stream.read(entry['data_size'])
        try:
            data = zlib.decompress(data, -15)
            f = open(name, 'wb')
            f.write(data)
            f.close()    
            print("ok")
        except:
            f = open(name, 'wb')
            f.write(data)
            f.close()   
