import csv
import re

with open("cleaned_data1.txt",'r+') as file:
    file.truncate(0)
with open("cleaned_data2.txt",'r+') as file:
    file.truncate(0)
with open("data_part2.csv",'r+') as file:
    file.truncate(0)

file1 = open('raw_data1.txt', 'r')
lines1 = file1.readlines()
with open('cleaned_data1.txt', 'a') as f:
    for line in lines1:
        arr = line.split(",")
        if(len(arr)==2):
        #print(re.search("\[(.*?)\]", arr[1]).group(1))
            f.write(re.search("\[(.*?)\]", arr[1]).group(1)+"\n")
file2 = open('raw_data2.txt', 'r')
lines2 = file2.readlines()
with open('cleaned_data2.txt', 'a') as f:
    for line in lines2:
        arr = line.split(" ")
        f.write(", ".join(arr))



with open('data_part1.csv', 'w', newline='', encoding='UTF8') as f:
    writer = csv.writer(f)
    writer.writerow([0]) #header
    for line in lines1:
        arr = line.split(",")
        if(len(arr)==2):
            val = float(re.search("\[(.*?)\]", arr[1]).group(1))
            writer.writerow([val])
with open('data_part2.csv', 'w', newline='', encoding='UTF8') as f:
    writer = csv.writer(f)
    writer.writerow([0,1,2,3,4,5,6,7,8,9]) #header
    for line in lines2:
        arr = list(map(int, line.strip().split()))
        writer.writerow(arr)