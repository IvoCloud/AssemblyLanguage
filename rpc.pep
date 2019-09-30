
         STRO intro,d        ;Imprimer intro
         STRO solManch,d     ;Soliciter nombre des manches a jouer
         DECI manches,d      ;Saisir nombre de manches a jouer dans (def .WORD 0)
         LDA manches,d       ;Load manches dans registre A 
         ORA 1,i             ;Bitwise OR, ajouter +1 si nombre dans A est pair
         STA manches,d       ;Stocker A dans manche
         LDA 0,i             ;Reset A

stats:   STRO reste,d 
         DECO manches,d
         STRO reste2,d
         LDA 0,i
         LDA manches,d 
         SUBA 1,i
         STA manches,d

main:    LDBYTEA choix1,d    ;Loader choix du joueur1 dans A (def .BYTE 0)
         BREQ sol1           ;Si valeur dans A (valeur de choix1 == 0), donc choix est vide --> aller al'instruction sol1
         LDBYTEA choix2,d    ;Loader choix du joueur2 dans A (def .BYTE 0)
         BREQ sol2           ;Si valeur dans A (valeur de choix2 == 0), donc choix est vide --> aller a l'instruction sol2
         BR jeu 

sol1:    STRO joueur1,d      ;Imprimer message de solicitation
         CHARI choix1,d      ;Saisir valeur du terminal dans choix1
         LDBYTEA choix1,d    ;Loader choix1 dans registre A
         BR valider          ;Saut a l'instruction valider

sol2:    STRO joueur2,d      ;Imprimer message de solicitation
         CHARI choix2,d      ;Saisir valeur du terminal dans choix2
         LDBYTEA choix2,d    ;Loader choix1 dans registre A
         BR valider          ;Saut a l'instruction valider
         
jeu:     LDBYTEA choix1,d    ;Instruction principale pour filtrer choix1
         CPA 'c',i 
         BREQ fCiseau        ;Si choix1 est c, brancher a fCiseau
         CPA 'p',i 
         BREQ fPapier        ;Si choix1 est p, brancher a fPapier
         CPA 'r',i 
         BREQ fRoche         ;Si choix1 est r, brancher a fRoche

fCiseau: LDBYTEA choix2,d    ;Instruction  pour filtrer choix2 si choix1 est ciseau
         CPA 'c',i
         BREQ egal           ;Tester si choix1 est choix 2 sont egaux et brancher a egal
         CPA 'r',i
         BREQ plus2          ;Tester si choix2 gagne 
         BR plus1            ;Sinon choix1 gagne

fPapier: LDBYTEA choix2,d    ;Instruction  pour filtrer choix2 si choix1 est papier
         CPA 'p',i
         BREQ egal           ;Tester si choix1 est choix 2 sont egaux et brancher a egal
         CPA 'r',i
         BREQ plus1          ;Tester si choix1 gagne 
         BR plus2            ;Sinon choix2 gagne

fRoche:  LDBYTEA choix2,d    ;Instruction  pour filtrer choix2 si choix1 est roche
         CPA 'r',i
         BREQ egal           ;Tester si choix1 est choix 2 sont egaux et brancher a egal
         CPA 'c',i
         BREQ plus1         ;Tester si choix1 gagne 
         BR plus2           ;Sinon choix2 gagne
         
plus1:   LDA 0,i             ;Ajouter point a joueur 1
         LDA score1,d
         ADDA 1,i
         STA score1,d
         STRO pointMsg,d
         CHARO "1",i
         CHARO "\n",i
         BR nullVal

plus2:   LDA 0,i             ;Ajouter point a joueur 2
         LDA score2,d
         ADDA 1,i
         STA score2,d
         STRO pointMsg,d
         CHARO "2",i
         CHARO "\n",i
         BR nullVal

nullVal: LDA 0,i             ;Annuler valeur de choix1 et choix2 
         STBYTEA choix1,d    ;choix1 = 0
         STBYTEA choix2,d    ;choix1 = 0
         BR difScor1

egal:    STRO nulle,d        ;Imprimer manche nulle
         BR nullVal 

difScor1:LDA 0,i             ;Calculer si le 
         LDA score1,d
         CPA score2,d
         BRLT difScor2
         SUBA score2,d
         CPA manches,d
         BRGT fin1 
         BR stats

difScor2:LDA 0,i 
         LDA score2,d
         SUBA score1,d
         CPA manches,d
         BRGT fin2
         BR stats

valider: CPA 'r',i           ;Valider si la valeur dans A (choix1 ou choix2) est un des char valides 
         BREQ buffer         ;Si valide aller a l'instruction buffer
         CPA 'p',i           ;repeter avec lettre p + buffer
         BREQ buffer              	
         CPA 'c',i           ;repeter avec lettre c + buffer
         BREQ buffer
         STRO erreur,d       ;Imprimer erreur si lettre dans A (choi1 ou choix2) n'est pas parmi les choix disponibles
         STOP                ;STOP 
         

         ;Verifie si l'entree a l'intruction choix1, choix2 est plus que 1 cahr et vider le tampon
buffer:  CHARI temp,d        ;Saisir char dans temp (def .BYTE 0)
         LDA 0,i             ;Reset A
         LDBYTEA temp,d      ;Load temp dans A
         CPA '\n',i          ;Comparer si char est \n (Enter)
         BREQ main           ;Si oui, retourner a main
         STRO errLen,d       ;Sinon imprimer erreur
         STOP                ;STOP                  


fin1:    STRO finMsg1,d
         BR finPts
fin2:    STRO finMsg2,d
         BR finPts
finPts:  DECO score1,d
         CHARO "-",i
         DECO score2,d
         STOP

intro:   .ASCII "-----------------------------------------------\n--- Bienvenue au jeu de roche-papier-ciseau ---\n-----------------------------------------------\n\x00"
solManch:.ASCII "Combien de manches voulez vous jouer: \x00"
joueur1: .ASCII "Joueur1, faites votre choix:[r/p/c]: \x00" 
joueur2: .ASCII "Joueur2, faites votre choix:[r/p/c]: \x00"
erreur:  .ASCII "Erreur, choix invalide \x00"
errLen:  .ASCII "Erreur, la longeur est plus qu'un charactere! \x00"
valide:  .ASCII "Valide!\x00"
nulle:   .ASCII "Manche nulle...\n\x00" 
pointMsg:.ASCII "+1 point pour joueur \x00" 
reste:   .ASCII "Il reste encore \x00"
reste2:  .ASCII " manches!\n\x00"
finMsg1: .ASCII "Joueur 1 gange la partie! Score final: \x00"
finMsg2: .ASCII "Joueur 2 gange la partie! Score final: \x00"
choix1:  .BYTE 0 
choix2:  .BYTE 0
temp:    .BYTE 0
manches: .WORD 2
score1:  .WORD 0
score2:  .WORD 0


.END
