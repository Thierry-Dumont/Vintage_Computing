#!/usr/bin/python3
dic={"PROCEDURE":"procedure","VALEUR":"value","TABLEAU":"array",\
     "DEBUT":"begin","FIN":"end","COMMENTAIRE":"comment",
     "ENTIER":"integer"," REEL":" real","POUR":"for","PAS":"step",
     "JUSQUA":"until","SI ":"if ","ALORS":"then","SINON":"else","FAIRE":"do",\
     "FROCEDURE":"procedure","ETIQUETTE":"label","ALLERA":"goto",
     "TANTQUE":"while","ET":"and","ABS":"abs","RAC2":"sqrt","SIGNE":"sign"}

def trans(line):
    for x in dic.keys():
        if line.find(x)>=0:
            line=line.replace(x,dic[x])
    return line.replace("\n","").lower()
def onlyblank(line):
    return len(line.replace(" ","").replace("\n",""))==0
#fname=input("file?")
fname="bairstow.alg"
with open(fname) as f:
    for line in f:
        #print(line)
        s=trans(line)
        if not onlyblank(s):
            print(s)
            
