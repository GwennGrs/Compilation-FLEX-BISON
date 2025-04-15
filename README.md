Token : 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
# Compilation-FLEX-BISON

## Introduction 

## 3. Analyseur lexical

### 3.1
Création du CMakeList et d'un analyseur de base.

Puis création du build afin de compilé notre première version de l'analyseur.
Je me place dans le build et compile avec cmake .. et make.

N'ayant rien défini dans le fichier de l'analyseur je me retrouve avec seulement un programme qui recopie ce que je lui donne en entrée.

### 3.2
J'ai ajouter dans mon facile.lex les informations nécessaires à la reconnaissance des mots "then" et "if". 
Je recompile ensuite et vois que tout les mots sont recopiés comme intialement mais que "if" et "found" renvoie : 
- if 
- "if found" 
- "then" 
- "then found"

#### Exercice 1
J'ai ensuite ajouter lettres autres mot du langage. Exemple : (not, or, for)
```
#define TOK_FOR 260
#define TOK_NOT 261

for {
assert(printf("'for' found"));
return TOK_FOR;
}

not {
assert(printf("'not' found"));
return TOK_NOT;
}
```
### 3.3
J'ai cette fois ajouter les ponctuations du langages.
#### Exercice 2
Puis ai ajouter les autres ponctuations du langage de la même manière que pour l'exercice 1.

### 3.4 
J'ai ajouter dans facile.lex un analyseur renvoyant le nombre de caractère d'une chaine (prenant en compte les nombres).

#### Exercice 3
J'ai réalisé la reconnaissance des nombres selon le principe de langage facile. 
```
0|[1-9][0-9]* {
assert(printf("identifier '%s' found", yytext));
return TOK_NUMBER;
}
```
Ce code identifie s'il detecte 0 ou une suite de chiffre commencant par un chiffre différent de 0.

### 3.5
Cela permet d'ignorer les retours à la ligne et les tabulations.
```
[ \t\n] ;
```

Ce code permet de reconnaitre le point de l'ignorer.
```
. {
return yytext[0];
}
```

## 4
### 4.1 
J'ai modifié le CMakeLists afin de permettre l'utilisation de Bison.
Création du fichier facile.y.

### 4.2
Je teste le compilateur.

## 5
### 5.1

#### Exercice 4 :
Cette exercice avait pour but d'ajouter des règles dans notre langage pour gérer des instructions "if".

J'ai pour cela du ajouter plusieurs éléments.
Pour commencer dans mpon analyseur lexical (le fichier .lex), j'ai ajouté 4 éléments : 
- Le token "if" pour la détection du mot if. (J'ai ajouté celui au dessus de l'identification des caractères pour un soucis de priorité).
- Le token ">" pour la détection de l'élément de comparaison "supérieur".
- Le token "<" pour la détection de l'élement de comparaison "inférieur".
- Le token "==" pour la détection de l'élément de comparaison d'égalité.

Une fois cela fais j'ai ajouté dans mon fichier .y les différents token.
