with open("cleaned_data1.txt",'r+') as file:
    file.truncate(0)
with open("cleaned_data2.txt",'r+') as file:
    file.truncate(0)


import re
file1 = open('raw_data1.txt', 'r')
lines = file1.readlines()
for line in lines:
    arr = line.split(",")
    if(len(arr)==2):
        #print(re.search("\[(.*?)\]", arr[1]).group(1))
        with open('cleaned_data1.txt', 'a') as file2:
            file2.write(re.search("\[(.*?)\]", arr[1]).group(1)+"\n")
            

file3 = open('raw_data2.txt', 'r')
lines = file3.readlines()
for line in lines:
    arr = line.split(" ")
    with open('cleaned_data2.txt', 'a') as file4:
        file4.write(", ".join(arr))