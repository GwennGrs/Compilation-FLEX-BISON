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
Pour commencer dans mpon analyseur lexical (le fichier facile.lex), j'ai ajouté 4 éléments : 
- Le token "if" pour la détection du mot if. (J'ai ajouté celui au dessus de l'identification des caractères pour un soucis de priorité).
- Le token ">" pour la détection de l'élément de comparaison "supérieur".
- Le token "<" pour la détection de l'élement de comparaison "inférieur".
- Le token "==" pour la détection de l'élément de comparaison d'égalité.

Une fois cela fais j'ai ajouté dans mon analyseur syntaxique (fichier facile.y) les différents token.
Puis défini des noeuds pour des instructions :
  %type<node> if_instruction
  %type<node> bool_expr

#### Exercice 5 :
J'ai ajouté 2 token : 
- Un token "else" pour la détection du mot 'else'.
- Un token "elseif" pour la détection du mot 'elseif'.

J'ai défini ensuite : 
```
if_instruction:
	TOK_IF TOK_OPEN_PARENTHESIS bool_expr TOK_CLOSE_PARENTHESIS instruction
	{
		$$ = g_node_new("if");
		g_node_append($$, $3); // bool_expr
		g_node_append($$, $5); // instruction
	}
;
```
```
bool_expr:
	expr TOK_INF expr
	{
		$$ = g_node_new("inf");
		g_node_append($$, $1);
		g_node_append($$, $3);
	}
|
	expr TOK_SUPP expr
	{
		$$ = g_node_new("supp");
		g_node_append($$, $1);
		g_node_append($$, $3);
	}
|
	expr TOK_EQ expr
	{
		$$ = g_node_new("eq");
		g_node_append($$, $1);
		g_node_append($$, $3);
	}
;
```

"if_instruction" permettant de définir le "if" entre les parenthèses et de créer des noeuds fils pour l'expression booléenne et l'instruction.
"bool_expr" défini les 3 expressions booléennes que l'on peut retrouver dans notre code. (inférieur : < ; supérieur : > ; égalité : ==)

Puis dans la fonction produce_code : 
```
else if (node->data == "if") {
		int label = label_counter++;
		produce_code(g_node_nth_child(node, 0)); 
		if (g_node_nth_child(node, 0)->data == "inf") {
			fprintf(stream, "	bge L%d\n", label); 
		} else if (g_node_nth_child(node, 0)->data == "supp") {
			fprintf(stream, "	ble L%d\n", label); 
		} else if (g_node_nth_child(node, 0)->data == "eq") {
			fprintf(stream, "	bne.un L%d\n", label); /
		}
		produce_code(g_node_nth_child(node, 1)); 
		fprintf(stream, "L%d:\n", label);
	} else if (node->data == "inf" || node->data == "supp" || node->data == "eq") {
		produce_code(g_node_nth_child(node, 0));
		produce_code(g_node_nth_child(node, 1));
	}
}
```
Trouvable dans -> https://en.wikipedia.org/wiki/List_of_CIL_instructions
"bge L" envoie l'instruction et va dans la fonction produce code si la condition est bonne, sinon va dans la ligne du dessous "label" afin de sauter l'instruction.
Le fonctionnement est similaire pour ble et bne. 
