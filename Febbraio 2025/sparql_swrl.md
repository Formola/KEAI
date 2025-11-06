# QUERY SPARQL

PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX : <http://xmlns.com/foaf/0.1/>>

prefissi comuni a tutte le query

a. Scelta una classe C, una data property P ed un Literal L, ricercare tutte le istanze
di C in cui è applicata P e in cui P assume un valore L.

SELECT ?person WHERE {
    ?person rdf:type :Person .
    ?person :age 24

}

![](/home/paolo/.config/marktext/images/2025-02-04-10-58-29-image.png)

b. Ricerca tutte le istanze della classe “Agent”

SELECT ?person WHERE {
    ?person rdf:type :Agent

}

![](/home/paolo/.config/marktext/images/2025-02-04-10-57-14-image.png)

c. Ricercare il numero delle persone presenti nell’ontologia.

SELECT (COUNT(?person) as ?person_count) WHERE {
 ?person rdf:type :Person 
}

![](/home/paolo/.config/marktext/images/2025-02-04-10-59-45-image.png)

d. Ricercare tutte le persone il cui numero di telefono inizia con “349”

SELECT ?person ?phone
WHERE {
  ?person a :Person ;
          :phoneNumber ?phone .

FILTER (STRSTARTS(STR(?phone), "349"))

}

![](/home/paolo/.config/marktext/images/2025-02-04-11-05-37-image.png)

e. Data una Object Property O, ricercare il range ed il dominio

SELECT ?domain ?range  
WHERE {  
 :haAmico rdfs:domain ?domain . 
:haAmico rdfs:range ?range

}

![](/home/paolo/.config/marktext/images/2025-02-04-11-07-15-image.png)

# Regole SWRL

a. Scegli o crea tre classi differenti, qui indicate in generale come A, B e C, e una
object property P (Puoi usare quelle già presenti o che hai creato in
precedenza).
Scrivi una regola per cui se esiste la relazione P tra due individui di A e B,
allora l’individuo di A appartiene anche alla classe C.

Gamer(?A) ^ haAmico(?A, ?B) -> Geeker(?A)

![](/home/paolo/.config/marktext/images/2025-02-04-11-10-29-image.png)

b. Scegli o crea tre classi differenti, qui indicate in generale come A, B e C, e due
object properties P1 e P2 (Puoi usare quelle già presenti o che hai creato in
precedenza).
Scrivi una regola per cui se esiste una relazione P tra due individui di A e B,
allora esiste una relazione P2 tra individui di A e C.

Person(?A) ^ haAmico(?A, ?B) ^ haGamingAccount(?B, ?G) -> haGamingAccount(?A, ?G)

(due amici potrebbero prestarsi un account)

![](/home/paolo/.config/marktext/images/2025-02-04-11-16-41-image.png)

c. Scegli o crea tre classi differenti, qui indicate in generale come A, B e una data
property D1 (Puoi usare quelle già presenti o che hai creato in precedenza).
Scrivi una regola per cui se un individuo di A possiede la proprietà D, ed essa
si trova in un range (a tua scelta), allora esso è individuo anche di B.

Gamer(?A) ^ age(?A, ?D) ^ swrlb:lessThan(?D, 25) -> TeenGamer(?A)

![](/home/paolo/.config/marktext/images/2025-02-04-11-21-52-image.png)

d. Se P è una persona il cui numero di telefono inizia con “349” e il cui sito web
è tradotto in lingua italiana e la cui mail termina con “.it” e possiede un
documento di identità rilasciato da un comune italiano e conosce almeno una
persona di origine italiana, allora P è di nazionalità italiana. Se per eseguire la
regola occorrono proprietà non presenti nell’ontologia, si è liberi di inserirle.

Person(?p) ^ 
phoneNumber(?p, ?phoneNumberValue) ^ 
swrlb:startsWith(?phoneNumberValue, "349") ^ 
hasWebsite(?p, ?w) ^ 
hasLanguage(?w, "it") ^ 
hasEmail(?p, ?e) ^ swrlb:endsWith(?e, ".it") ^ 
hasDocumento(?p, ?documento) ^ 
èRilasciatoDa(?documento, ?comune) ^ 
ComuneItaliano(?comune) ^ 
conosce(?p, ?other) ^ 
haNazionalità(?other, "Italiana") 
-> haNazionalità(?p, "Italiana")

![](/home/paolo/.config/marktext/images/2025-02-04-11-45-11-image.png)
