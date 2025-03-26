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
#### Exercice 2
